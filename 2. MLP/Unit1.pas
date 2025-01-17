{***Pascal program (c) 2019 Steven Seaver
5-Class Classifier using Multi-layered Perceptron
and Error-back Propagation Learning Method.

Biomedical Engineering Department
Electrical Technology Faculty
Institut Teknologi Sepuluh Nopember
Surabaya***}
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Menus, TeeGDIPlus, ExtCtrls, TeeProcs,
  TeEngine, Chart, Math, Series, TeeSurfa, jpeg;

type
  arr = array[-5..500] of double;
  arr2= array[-100..500,-100..500] of double;
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Fi1: TMenuItem;
    Edit1: TMenuItem;
    Searcg1: TMenuItem;
    Help1: TMenuItem;
    OpenFile1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    Close1: TMenuItem;
    Chart2: TChart;
    GroupBox1: TGroupBox;
    SpeedButton2: TSpeedButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    About1: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Edit2: TEdit;
    Edit3: TEdit;
    SpeedButton4: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox4: TGroupBox;
    ListBox6: TListBox;
    ListBox7: TListBox;
    ListBox8: TListBox;
    ListBox9: TListBox;
    ListBox10: TListBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Edit7: TEdit;
    Label17: TLabel;
    Edit8: TEdit;
    Label18: TLabel;
    Timer1: TTimer;
    SpeedButton1: TSpeedButton;
    Series2: TFastLineSeries;
    Label5: TLabel;
    ListBox5: TListBox;
    ListBox4: TListBox;
    Label4: TLabel;
    ListBox3: TListBox;
    Label3: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Label13: TLabel;
    Label12: TLabel;
    Chart1: TChart;
    Series1: TPointSeries;
    GroupBox5: TGroupBox;
    SpeedButton6: TSpeedButton;
    Edit10: TEdit;
    Edit9: TEdit;
    Label20: TLabel;
    Label21: TLabel;
    ListBox11: TListBox;
    Label19: TLabel;
    GroupBox6: TGroupBox;
    Label6: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton5: TSpeedButton;
    ListBox12: TListBox;
    GroupBox7: TGroupBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label22: TLabel;
    ComboBox4: TComboBox;
    Label23: TLabel;
    Image1: TImage;
    Image2: TImage;
    Chart3: TChart;
    SpeedButton7: TSpeedButton;
    Series4: TFastLineSeries;
    Series5: TFastLineSeries;
    Series6: TFastLineSeries;
    Series7: TFastLineSeries;
    Series8: TFastLineSeries;
    Series9: TFastLineSeries;
    SpeedButton8: TSpeedButton;
    Chart4: TChart;
    Chart5: TChart;
    Series10: TColorGridSeries;
    Series3: TColorGridSeries;
    Edit11: TEdit;
    Label24: TLabel;
    Label25: TLabel;
    procedure delay(lama:longint);
    function mlp(input1,input2:double):arr;
    procedure Close1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Inputrandomizer();
    procedure Inputshow();
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure learning();
    procedure OpenFile1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    //procedure Timer1Timer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure saving(selector:integer);
    procedure displayweightthres();
    procedure showwth();
    procedure showwthold();
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  err_mlp,x1,x2,tht1,tht2,tht3,th1,th2,th3,v1,v2,v3,y1,y2,y3,g1,g2,g3,er,error,delta,delta1,delta2,delta3:arr;
  t1old,t2old,t3old:arr;
  yy3,d,w1,w2,w3,wt1,wt2,wt3:arr2;
  w1old,w2old,w3old:arr2;
  kelas,ndata,hlayer1node,hlayer2node,iterasi:integer;
  totalerror,miu,alpha,epsilon,temp,tempx,tempy,ekuadrat,mse_total:extended;
  start,stop,elapsed:cardinal;
implementation

{$R *.dfm}

procedure TForm1.delay(lama:longint);
var
  ref:longint;
begin
  ref:=gettickcount;
  repeat application.processmessages;
  until ((gettickcount-ref)>=lama);
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Inputshow();
var
  i:integer;
begin
  listbox1.Items.Add('Class 1');
  listbox2.Items.Add('Class 1 ');   //input class 1
  for i:=1 to 15 do begin
    listbox1.Items.Add('X1['+inttostr(i)+'] = '+format('%.5f',[x1[i]]));
    listbox2.Items.Add('X2['+inttostr(i)+'] = '+format('%.5f',[x2[i]]));
    series1.AddXY(x1[i],x2[i]);
  end;
  listbox1.Items.Add('Class 2');   //input class 2
  listbox2.Items.Add('Class 2');
  for i:=16 to 40 do begin               //16 to 40
    listbox1.Items.Add('X1['+inttostr(i)+'] = '+format('%.5f',[x1[i]]));
    listbox2.Items.Add('X2['+inttostr(i)+'] = '+format('%.5f',[x2[i]]));
    series1.AddXY(x1[i],x2[i]);
  end;
  listbox1.Items.Add('Class 3');     //input class 3
  listbox2.Items.Add('Class 3');
  for i:=41 to 65 do begin          //41 to 65
    listbox1.Items.Add('X1['+inttostr(i)+'] = '+format('%.5f',[x1[i]]));
    listbox2.Items.Add('X2['+inttostr(i)+'] = '+format('%.5f',[x2[i]]));
    series1.AddXY(x1[i],x2[i]);
  end;
  listbox1.Items.Add('Class 4');    //input class 4
  listbox2.Items.Add('Class 4');
  for i:=66 to 90 do begin           //66 to 90
    listbox1.Items.Add('X1['+inttostr(i)+'] = '+format('%.5f',[x1[i]]));
    listbox2.Items.Add('X2['+inttostr(i)+'] = '+format('%.5f',[x2[i]]));
    series1.AddXY(x1[i],x2[i]);
  end;
  listbox1.Items.Add('Class 5');    //input class 5
  listbox2.Items.Add('Class 5');
  for i:=91 to 115 do begin         //91 to 115
    listbox1.Items.Add('X1['+inttostr(i)+'] = '+format('%.5f',[x1[i]]));
    listbox2.Items.Add('X2['+inttostr(i)+'] = '+format('%.5f',[x2[i]]));
    series1.AddXY(x1[i],x2[i]);
  end;
end;

procedure TForm1.Inputrandomizer();
var
  i:integer;
begin
//input class 1
  for i:=1 to 15 do begin
    x1[i]:=randg(0,0.5);     //X[l,q] dengan q menandakan jumlah input dan l adalah jumlah dataa
    x2[i]:=randg(0,0.5);
  end;
//input class 2
  for i:=16 to 40 do begin               //16 to 40
    x1[i]:=randg(5,0.5);
    x2[i]:=randg(5,0.5);
  end;
//input class 3
  for i:=41 to 65 do begin          //41 to 65
    x1[i]:=randg(-5,0.5);
    x2[i]:=randg(5,0.5);
  end;
//input class 4
  for i:=66 to 90 do begin           //66 to 90
    x1[i]:=randg(-5,0.5);
    x2[i]:=randg(-5,0.5);
  end;
//input class 5
  for i:=91 to 115 do begin         //91 to 115
    x1[i]:=randg(5,0.5);
    x2[i]:=randg(-5,0.5);
  end;
  inputshow();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Listbox1.Clear;
  //d[l,q] q adalah class, q=1--> class 1 dst
  d[1,1]:=1;d[1,2]:=0;d[1,3]:=0;d[1,4]:=0;d[1,5]:=0;
  d[2,1]:=0;d[2,2]:=1;d[2,3]:=0;d[2,4]:=0;d[2,5]:=0;
  d[3,1]:=0;d[3,2]:=0;d[3,3]:=1;d[3,4]:=0;d[3,5]:=0;
  d[4,1]:=0;d[4,2]:=0;d[4,3]:=0;d[4,4]:=1;d[4,5]:=0;
  d[5,1]:=0;d[5,2]:=0;d[5,3]:=0;d[5,4]:=0;d[5,5]:=1;
  timer1.Enabled:=false;
  Label6.Caption:='Status: Ready. Please Randomize Data First!';
  Listbox12.Items.Add('How to use!');
  Listbox12.Items.Add('1. Randomize input data');
  Listbox12.Items.Add('2. Click Search W/Th');
  Listbox12.Items.Add('3. Start Learning');
  Listbox12.Items.Add('4. You can save the ANN model');
  Listbox12.Items.Add('5. You can load saved ANN model');
end;

procedure TForm1.learning();
var
  h,i,j,k,l,q,n,m,c,waktu:integer;
begin
  Label6.Caption:='Status: Learning...';
  ndata:=115;
  hlayer1node:=strtoint(edit2.Text);
  hlayer2node:=strtoint(edit3.text);
  kelas:=5;
  //mulai training
  for i:=1 to ndata do
  begin
   //forward  layer 1
    for j:=1 to hlayer1node do begin
      tempx:=0; tempy:=0;
      tempx:=tempx+x1[i]*w1[j,1];  //q input pattern
      tempy:=tempy+x2[i]*w1[j,2];  //disini ganti
      v1[j]:= tempx+tempy+th1[j];
      y1[j]:= 1/(1+exp(-alpha*v1[j]));
      g1[j]:= alpha*y1[j]*(1-y1[j]);
    end;
    //layer 2
    for k:=1 to hlayer2node do begin
   	  temp:=0;
   	  for j:=1 to hlayer1node do begin
        temp:=temp+y1[j]*w2[k,j];
   	  end;
   	  v2[k]:= temp+th2[k];
   	  y2[k]:= 1/(1+exp(-alpha*v2[k]));
		  g2[k]:= alpha*y2[k]*(1-y2[k]);
    end;
    //layer 3
    for l:=1 to kelas do begin
   	  temp:=0;
   	  for k:=1 to hlayer2node do begin
        temp:=temp+y2[k]*w3[l,k];
   	  end;
   	  v3[l]:= temp+th3[l];
   	  y3[l]:= 1/(1+exp(-alpha*v3[l]));
		  g3[l]:= alpha*y3[l]*(1-y3[l]);
    end;
    //backward
    if (i<=15) then q:=1;
    if ((i>15) and (l<=40)) then q:=2;
    if ((i>40) and (l<=65)) then q:=3;
    if ((i>65) and (l<=90)) then q:=4;
    if ((i>90) and (l<=115)) then q:=5;
    //menghitung error
    ekuadrat:=0;

    for l:=1 to kelas do begin
      er[l]:=d[l,q]-y3[l];
      ekuadrat:=ekuadrat+sqr(er[l]);
    end;
    error[q]:=0.5*ekuadrat;
    series2.AddXY(iterasi,error[q]);

    //menghitung delta error
    //delta error layer3
    for l:=1 to kelas do begin
      delta3[l]:= (d[l,q]-y3[l])*g3[l];
    end;

    //delta error layer2
    for k:=1 to hlayer2node do begin
      temp:=0;
      for l:=1 to kelas do begin
        temp:=temp+delta3[l]*w3[l,k];
      end;
      delta2[k]:= temp*g2[k];
    end;

    //delta error layer1
    for j:=1 to hlayer1node do begin
      temp:=0;
      for k:=1 to hlayer2node do begin
        temp:=temp+delta2[k]*w2[k,j];
      end;
      delta1[j]:= temp*g1[j];
    end;

    //update w dan th layer 3
    for l:= 1 to kelas do begin
      for k:= 1 to hlayer2node do begin
        wt3[l,k]:=w3[l,k];
        w3[l,k]:=w3[l,k]+miu*delta3[l]*y2[k];
      end;
      tht3[l]:=th3[l];
      th3[l]:=th3[l]+miu*delta3[l];
    end;

    //update w dan th layer 2
    for k:= 1 to hlayer2node do begin
      for j:= 1 to hlayer1node do begin
        wt2[k,j]:=w2[k,j];
        w2[k,j]:=w2[k,j]+miu*delta2[k]*y1[j];
      end;
      tht2[k]:=th2[k];
      th2[k]:=th2[k]+miu*delta2[k];
    end;

    //update w dan th layer 1
    for j:= 1 to hlayer1node do begin
      wt1[j,1]:=w1[j,1];
      wt1[j,2]:=w1[j,2];
      w1[j,1]:=w1[j,1]+miu*delta1[j]*x1[j];
      w1[j,2]:=w1[j,2]+miu*delta1[j]*x2[j];  //disini ganti
      tht1[j]:=th1[j];
      th1[j]:=th1[j]+miu*delta1[j];
    end;
  end;
  //akhir training

  //mengecek output y3[l,q] menggunakan w dan th terakhir
  for i:=1 to ndata do begin
    //forward
    //menghitung output layer 1
    for j:=1 to hlayer1node do begin
      tempx:=0; tempy:=0;
      tempx:=tempx+x1[i]*wt1[j,1];
      tempy:=tempy+x2[i]*wt1[j,2];  //q input pattern
      v1[j]:= tempx+tempy+tht1[j];
      y1[j]:= 1/(1+exp(-alpha*v1[j]));
    end;
    //menghitung output layer 2
    for k:=1 to hlayer2node do begin
   	  temp:=0;
   	  for j:=1 to hlayer1node do begin
        temp:=temp+y1[j]*wt2[k,j];
   	  end;
   	  v2[k]:= temp+tht2[k];
   	  y2[k]:= 1/(1+exp(-alpha*v2[k]));
		  g2[k]:= alpha*y2[k]*(1-y2[k]);
    end;
    if (i<=15) then q:=1;
    if ((i>15) and (l<=40)) then q:=2;
    if ((i>40) and (l<=65)) then q:=3;
    if ((i>65) and (l<=90)) then q:=4;
    if ((i>90) and (l<=115)) then q:=5;
    listbox6.Clear;
    listbox7.Clear;
    listbox8.Clear;
    listbox9.Clear;
    listbox10.Clear;
    //menghitung output layer 3
    for l:=1 to kelas do begin
   	  temp:=0;
   	  for k:=1 to hlayer2node do begin
        temp:=temp+y2[k]*wt3[l,k];
   	  end;
   	  v3[l]:= temp+tht3[l];
   	  yy3[l,q]:= 1/(1+exp(-alpha*v3[l]));
      listbox6.Items.Add('y3['+inttostr(l)+']='+format('%.6f',[yy3[l,1]]));
      listbox7.Items.Add('y3['+inttostr(l)+']='+format('%.6f',[yy3[l,2]]));
      listbox8.Items.Add('y3['+inttostr(l)+']='+format('%.6f',[yy3[l,3]]));
      listbox9.Items.Add('y3['+inttostr(l)+']='+format('%.6f',[yy3[l,4]]));
      listbox10.Items.Add('y3['+inttostr(l)+']='+format('%.6f',[yy3[l,5]]));
    end;
    iterasi:=iterasi+1;
    edit7.Text:=inttostr(iterasi);
  end;
  //menghitung mse total
  mse_total:=0;
  for q:=1 to 5 do begin
    mse_total:=mse_total+error[q];
  end;
  stop:=GetTickCount;
  elapsed:=stop-start;
  edit11.Text:=floattostr(elapsed/1000);
  //series1.AddXY(iterasi,mse_total);
  edit8.Text:=format('%.5f',[mse_total]);
  Label6.Caption:='Status: Learning...';
  //konvergen??
  if mse_total<epsilon then begin
    //timer1.Enabled:=false;
    Windows.Beep(1000,1000);
    Speedbutton1.Caption:='Start';
    Label6.Caption:='Status: Learning done! Displaying results!';
    
    displayweightthres();
    delay(2000);
    Label6.Caption:='Status: Updated W and Th can be used! Test it.';
    for j:=1 to hlayer1node do begin
      for i:=1 to 2 do begin
        w1[j,i]:=wt1[j,i];
        //series4.AddXYZ(j,i,w1[j,i]);
      end;
    end;
    for j:=1 to hlayer1node do begin
      th1[j]:=tht1[j];
    end;
    for k:=1 to hlayer2node do begin
      for j:=1 to hlayer1node do begin
        w2[k,j]:=wt2[k,j];
        //series7.AddXYZ(k,j,w2[j,i]);
      end;
    end;
    for k:=1 to hlayer2node do begin
      th2[k]:=tht2[k];
    end;
    for l:=1 to kelas do begin
      for k:= 1 to hlayer2node do begin
        w3[l,k]:=wt3[l,k];
        //series8.AddXYZ(k,j,w3[j,i]);
      end;
    end;
    for l:=1 to kelas do begin
      th3[l]:=tht3[l];
    end;
  end;
end;

function TForm1.mlp(input1,input2:double):arr;
var
  pointer,j,k,l:integer;
begin
    //forward
    //menghitung output layer 1
    for j:=1 to hlayer1node do begin
      tempx:=0; tempy:=0;
      tempx:=tempx+input1*w1[j,1];
      tempy:=tempy+input2*w1[j,2];  //q input pattern
      v1[j]:= tempx+tempy+th1[j];
      y1[j]:= 1/(1+exp(-alpha*v1[j]));
    end;
    //menghitung output layer 2
    for k:=1 to hlayer2node do begin
   	  temp:=0;
   	  for j:=1 to hlayer1node do begin
        temp:=temp+y1[j]*w2[k,j];
   	  end;
   	  v2[k]:= temp+th2[k];
   	  y2[k]:= 1/(1+exp(-alpha*v2[k]));
		  g2[k]:= alpha*y2[k]*(1-y2[k]);
    end;
    listbox11.Clear;
    //menghitung output layer 3
    for l:=1 to kelas do begin
   	  temp:=0;
   	  for k:=1 to hlayer2node do begin
        temp:=temp+y2[k]*w3[l,k];
   	  end;
   	  v3[l]:= temp+th3[l];
   	  y3[l]:= 1/(1+exp(-alpha*v3[l]));
      listbox11.Items.Add('y3['+inttostr(l)+']='+format('%.6f',[y3[l]]));
    end;
    listbox11.Items.Add('--------------------------------');
    y3[-4]:=0;
    y3[-3]:=0;
    y3[-2]:=0;
    y3[-1]:=0;
    y3[0]:=0;
    for l:=1 to kelas do begin          //determine input class algorithm (c) steven seaver
      if (y3[l]>y3[l-4])and (y3[l]>y3[l-3]) and (y3[l]>y3[l-2])
      and (y3[l]>y3[l-1]) and (y3[l]>y3[l+1])
      and (y3[l]>y3[l+2]) and(y3[l]>y3[l+3]) and(y3[l]>y3[l+4]) then begin
        listbox11.Items.Add('Class '+inttostr(l));
        pointer:=l;
        break;
      end;
    end;
    listbox11.Items.Add('--------------------------------');
    for l:=1 to kelas do begin
      if pointer=l then begin
        err_mlp[l]:=1-y3[l];
      end else
      err_mlp[l]:=0-y3[l];
      listbox11.Items.Add('Error['+inttostr(l)+']='+format('%.6f',[err_mlp[l]]));
    end;
    totalerror:=(err_mlp[1]+err_mlp[2]+err_mlp[3]+err_mlp[4]+err_mlp[5])/5;
    listbox11.Items.Add('Mean error = '+format('%.6f',[totalerror]));
    mlp:=y3;
end;

procedure TForm1.displayweightthres();
var
  i,j,k,l:integer;
begin
    hlayer1node:=strtoint(edit2.Text);        //search randomized initial weight and threshold
    hlayer2node:=strtoint(edit3.Text);
    listbox3.Clear; listbox4.Clear; listbox5.Clear;
    //displaying latest weight and threshold after training
    for j:=1 to hlayer1node do begin
      for i:=1 to 2 do begin
        listbox3.Items.Add('W1['+inttostr(j)+','+inttostr(i)+'] = '+floattostr(wt1[j,i]));
      end;
    end;
    for j:=1 to hlayer1node do begin
      listbox3.Items.Add('Th1['+inttostr(j)+'] = '+floattostr(tht1[j]));
    end;
    for k:=1 to hlayer2node do begin
      for j:=1 to hlayer1node do begin
        listbox4.Items.Add('W2['+inttostr(k)+','+inttostr(j)+'] = '+floattostr(wt2[k,j]));
      end;
    end;
    for k:=1 to hlayer2node do begin
      listbox4.Items.Add('Th2['+inttostr(k)+'] = '+floattostr(tht2[k]));
    end;
    for l:=1 to kelas do begin
      for k:= 1 to hlayer2node do begin
        listbox5.Items.Add('W3['+inttostr(l)+','+inttostr(k)+'] = '+floattostr(wt3[l,k]));
      end;
    end;
    for l:=1 to kelas do begin
      listbox5.Items.Add('Th3['+inttostr(l)+'] = '+floattostr(tht3[l]));
    end;
end;

procedure TForm1.saving(selector:integer);
var
  i,j,k,l:integer;
  filename1:textfile;
begin
  if savedialog1.Execute then begin
    assignfile(filename1,savedialog1.FileName+'.txt');
    rewrite(filename1);
    writeln(filename1,hlayer1node);
    writeln(filename1,hlayer2node);
    if selector=1 then begin                    //saving cuurent w
      for j:=1 to hlayer1node do begin
        for i:=1 to 2 do begin
          writeln(filename1,floattostr(w1[j,i]));
        end;
      end;
      for j:=1 to hlayer1node do begin
        writeln(filename1,floattostr(th1[j]));
      end;
      for k:=1 to hlayer2node do begin
        for j:=1 to hlayer1node do begin
          writeln(filename1,floattostr(w2[k,j]));
        end;
      end;
      for k:=1 to hlayer2node do begin
        writeln(filename1,floattostr(th2[k]));
      end;
      for l:=1 to kelas do begin
        for k:= 1 to hlayer2node do begin
          writeln(filename1,floattostr(w3[l,k]));
        end;
      end;
      for l:=1 to kelas do begin
        writeln(filename1,floattostr(th3[l]));
      end;
    end else if selector=2 then begin             //saving current ANN model both input and weight
      for i:=1 to 115 do begin
        writeln(filename1,floattostr(x1[i]));
      end;
      for i:=1 to 115 do begin
        writeln(filename1,floattostr(x2[i]));
      end;
      for j:=1 to hlayer1node do begin
        for i:=1 to 2 do begin
          writeln(filename1,floattostr(w1[j,i]));
        end;
      end;
      for j:=1 to hlayer1node do begin
        writeln(filename1,floattostr(th1[j]));
      end;
      for k:=1 to hlayer2node do begin
        for j:=1 to hlayer1node do begin
          writeln(filename1,floattostr(w2[k,j]));
        end;
      end;
      for k:=1 to hlayer2node do begin
        writeln(filename1,floattostr(th2[k]));
      end;
      for l:=1 to kelas do begin
        for k:= 1 to hlayer2node do begin
          writeln(filename1,floattostr(w3[l,k]));
        end;
      end;
      for l:=1 to kelas do begin
        writeln(filename1,floattostr(th3[l]));
      end;
    end;
  end;
  closefile(filename1);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);   //start learning button
var
  i,j,k,l:integer;
begin
  iterasi:=0;
  alpha:=strtofloat(edit4.Text);
  miu:=strtofloat(edit5.Text);
  epsilon:=strtofloat(edit6.Text);
  if speedbutton1.Caption='Start' then begin
    start:=GetTickCount;                              //timer start
    speedbutton1.Caption:='Stop';
    series2.Clear;
    //timer1.Enabled:=true;
    repeat
      learning;
      delay(1);
    until (speedbutton1.Caption='Start');
  end
  else if speedbutton1.caption='Stop' then begin
    speedbutton1.Caption:='Start';
    //timer1.Enabled:=false;
    Label6.Caption:='Status: Learning Stopped! Displaying latest weight and threshold!';
    displayweightthres();
    delay(2000);
    Label6.Caption:='Status: Updated W and Th can be used! Test it.';
    for j:=1 to hlayer1node do begin
      for i:=1 to 2 do begin
        w1[j,i]:=wt1[j,i];
        //series4.AddXYZ(j,i,w1[j,i]);
      end;
    end;
    for j:=1 to hlayer1node do begin
      th1[j]:=tht1[j];
    end;
    for k:=1 to hlayer2node do begin
      for j:=1 to hlayer1node do begin
        w2[k,j]:=wt2[k,j];
        //series7.AddXYZ(k,j,w2[j,i]);
      end;
    end;
    for k:=1 to hlayer2node do begin
      th2[k]:=tht2[k];
    end;
    for l:=1 to kelas do begin
      for k:= 1 to hlayer2node do begin
        w3[l,k]:=wt3[l,k];
        //series8.AddXYZ(k,j,w3[j,i]);
      end;
    end;
    for l:=1 to kelas do begin
      th3[l]:=tht3[l];
    end;
  end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  series1.Clear;
  listbox1.Clear;
  listbox2.Clear;
  inputrandomizer();
  Label6.Caption:='Status: Data Randomized, select Search Weight and Th';
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
var
  i,j,k,l:integer;
begin
  kelas:=5;
  ndata:=115;
  listbox3.Clear;listbox4.Clear;listbox5.Clear;
  hlayer1node:=strtoint(edit2.Text);        //search randomized initial weight and threshold
  hlayer2node:=strtoint(edit3.Text);
  for j:=1 to hlayer1node do begin
    for i:=1 to 2 do begin
      w1[j,i]:=randg(0,0.5);
      listbox3.Items.Add('W1['+inttostr(j)+','+inttostr(i)+'] = '+floattostr(w1[j,i]));
    end;
  end;
  for j:=1 to hlayer1node do begin
    th1[j]:=randg(0,0.5);
    listbox3.Items.Add('Th1['+inttostr(j)+'] = '+floattostr(th1[j]));
  end;
  for k:=1 to hlayer2node do begin
    for j:=1 to hlayer1node do begin
      w2[k,j]:=randg(0,0.5);
      listbox4.Items.Add('W2['+inttostr(k)+','+inttostr(j)+'] = '+floattostr(w2[k,j]));
    end;
  end;
  for k:=1 to hlayer2node do begin
    th2[k]:=randg(0,0.5);
    listbox4.Items.Add('Th2['+inttostr(k)+'] = '+floattostr(th2[k]));
  end;
  for l:=1 to kelas do begin
    for k:= 1 to hlayer2node do begin
      w3[l,k]:=randg(0,0.5);
      listbox5.Items.Add('W3['+inttostr(l)+','+inttostr(k)+'] = '+floattostr(w3[l,k]));
    end;
  end;
  for l:=1 to kelas do begin
    th3[l]:=randg(0,0.5);
    listbox5.Items.Add('Th3['+inttostr(l)+'] = '+floattostr(th3[l]));
  end;
  Label6.Caption:='Status: Initial W and Th determined, start learning!';
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
   kelas:=5;
  ndata:=115;
  saving(1);
  Label6.Caption:='Status: New Updated Weight Saved';
  delay(2000);
  Label6.Caption:='Status: Ready'
end;

procedure TForm1.SaveAs1Click(Sender: TObject);
begin
  kelas:=5;
  ndata:=115;
  saving(2);
  Label6.Caption:='Status: ANN Model Saved';
  delay(2000);
  Label6.Caption:='Status: Ready'
end;

procedure TForm1.OpenFile1Click(Sender: TObject);
var
  i,j,k,l:integer;
  filename2:textfile;
begin
  kelas:=5;
  ndata:=115;
  Label6.Caption:='Status: Weight File Opened';
  listbox3.Clear;
  listbox4.Clear;
  listbox5.Clear;
  if opendialog1.Execute then begin
    assignfile(filename2,opendialog1.FileName);
    reset(filename2);
    readln(filename2,hlayer1node);
    edit2.Text:=inttostr(hlayer1node);
    readln(filename2,hlayer2node);
    edit3.Text:=inttostr(hlayer2node);
    //read input data
    for i:=1 to 115 do begin
      readln(filename2,x1[i]);
    end;
    for i:=1 to 115 do begin
      readln(filename2,x2[i]);
    end;
    inputshow();
    //read layer input to hidden layer1
    for j:=1 to hlayer1node do begin
      for i:=1 to 2 do begin
        readln(filename2,w1[j,i]);
        listbox3.Items.Add('W1['+inttostr(j)+','+inttostr(i)+'] = '+floattostr(w1[j,i]));
      end;
    end;
    for j:=1 to hlayer1node do begin
      readln(filename2,th1[j]);
      listbox3.Items.Add('Th1['+inttostr(j)+'] = '+floattostr(th1[j]));
    end;
    //hidden layer 1 to h layer 2
    for k:=1 to hlayer2node do begin
      for j:=1 to hlayer1node do begin
        readln(filename2,w2[k,j]);
        listbox4.Items.Add('W2['+inttostr(k)+','+inttostr(j)+'] = '+floattostr(w2[k,j]));
      end;
    end;
    for k:=1 to hlayer2node do begin
      readln(filename2,th2[k]);
      listbox4.Items.Add('Th2['+inttostr(k)+'] = '+floattostr(th2[k]));
    end;
    //hidden layer 2 to output layer
    for l:=1 to kelas do begin
      for k:= 1 to hlayer2node do begin
        readln(filename2,w3[l,k]);
        listbox5.Items.Add('W3['+inttostr(l)+','+inttostr(k)+'] = '+floattostr(w3[l,k]));
      end;
    end;
    for l:=1 to kelas do begin
      readln(filename2,th3[l]);
      listbox5.Items.Add('Th3['+inttostr(l)+'] = '+floattostr(th3[l]));
    end;
  end;
  closefile(filename2);
  delay(2000);
  Label6.Caption:='Status: Ready'
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  listbox1.Clear;
  listbox2.Clear;
  listbox3.Clear;
  listbox4.Clear;
  listbox5.Clear;
  listbox6.Clear;
  listbox7.Clear;
  listbox8.Clear;
  listbox9.Clear;
  listbox10.Clear;
  listbox11.Clear;
  series1.Clear;
  series2.Clear;
  series3.Clear;
  series4.Clear;
  series5.Clear;
  series6.Clear;
  series7.Clear;
  series8.Clear;
  series9.Clear;
  series10.Clear;
end;


procedure TForm1.SpeedButton6Click(Sender: TObject);
var
  in1,in2:double;
begin
  if combobox4.Text='Random' then begin
    edit9.Text:=floattostr(randg(0,5));
    edit10.Text:=floattostr(randg(0,5));
    in1:=strtofloat(edit9.Text);
    in2:=strtofloat(edit10.Text);
    mlp(in1,in2);
  end
  else if combobox4.Text='Manual' then begin
    in1:=strtofloat(edit9.Text);
    in2:=strtofloat(edit10.Text);
    mlp(in1,in2);
  end
  else
    showmessage('Select type!');
end;

procedure TForm1.showwthold();   //show old saved th and w to be compared
var
  i,j,k,l:integer;
begin
  series7.Clear;
  series8.Clear;
  series9.Clear;
  series10.Clear;
  hlayer1node:=strtoint(edit2.Text);        //search randomized initial weight and threshold
  hlayer2node:=strtoint(edit3.Text);
    if (Combobox1.Text='Layer 1 to 2 (W1)') then begin
      for j:=1 to hlayer1node do begin
        for i:=1 to 2 do begin
          series10.AddXYZ(j,w1old[j,i],i);
        end;
      end;
    end;
    if (Combobox2.Text='Threshold 1 to 2 (T1)') then begin
      for j:=1 to hlayer1node do begin
        series7.AddXY(j,t1old[j]);
      end;
    end;
    if (Combobox1.Text='Layer 2 to 3 (W2)') then begin
      for k:=1 to hlayer2node do begin
        for j:=1 to hlayer1node do begin
          series10.AddXYZ(k,w2old[k,j],j);
        end;
      end;
    end;
    if (Combobox2.Text='Threshold 2 to 3 (T2)') then begin
      for k:=1 to hlayer2node do begin
        series8.AddXY(k,t2old[k]);
      end;
    end;
    if (Combobox1.Text='Layer 3 to 4 (W3)') then begin
      for l:=1 to kelas do begin
        for k:= 1 to hlayer2node do begin
          series10.AddXYZ(l,w3old[l,k],k);
        end;
      end;
    end;
    if (Combobox2.Text='Threshold 3 to 4 (T3)') then begin
      for l:=1 to kelas do begin
        series9.AddXY(l,t3old[l]);
      end;
    end;
end;

procedure TForm1.showwth();     //show current th and w
var
  i,j,k,l: integer;
begin
  series3.Clear;
  series4.Clear;
  series5.Clear;
  series6.Clear;
  hlayer1node:=strtoint(edit2.Text);        //search randomized initial weight and threshold
  hlayer2node:=strtoint(edit3.Text);
    if (Combobox1.Text='Layer 1 to 2 (W1)') then begin
      for j:=1 to hlayer1node do begin
        for i:=1 to 2 do begin
          //imageF[j,i] := w1[j,i]*400+380;
          series3.AddXYZ(j,w1[j,i],i);
        end;
      end;
    end;
    if (Combobox2.Text='Threshold 1 to 2 (T1)') then begin
      for j:=1 to hlayer1node do begin
        series4.AddXY(j,th1[j]);
      end;
    end;
    if (Combobox1.Text='Layer 2 to 3 (W2)') then begin
      for k:=1 to hlayer2node do begin
        for j:=1 to hlayer1node do begin
          //imageF[k,j] := w2[k,j]*400+380;
          series3.AddXYZ(k,w2[k,j],j);
        end;
      end;
    end;
    if (Combobox2.Text='Threshold 2 to 3 (T2)') then begin
      for k:=1 to hlayer2node do begin
        series5.AddXY(k,th2[k]);
      end;
    end;
    if (Combobox1.Text='Layer 3 to 4 (W3)') then begin
      for l:=1 to kelas do begin
        for k:= 1 to hlayer2node do begin
          //imageF[l,k] := w3[l,k]*400+380;
          series3.AddXYZ(l,w3[l,k],k);
        end;
      end;
    end;
    if (Combobox2.Text='Threshold 3 to 4 (T3)') then begin
      for l:=1 to kelas do begin
        series6.AddXY(l,th3[l]);
      end;
    end;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
  showwth();
  showwthold();
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  showwth();
  showwthold();
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  showwth();
  showwthold();
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
var
  i,j,k,l:integer;
  filename3: TextFile;
begin
  listbox3.Clear;
  listbox4.Clear;
  listbox5.Clear;
  series7.Clear;
  series8.Clear;
  series9.Clear;
  kelas:=5;
  if opendialog1.Execute then begin
    assignfile(filename3,opendialog1.FileName);
    reset(filename3);
    readln(filename3,hlayer1node);
    edit2.Text:=inttostr(hlayer1node);
    readln(filename3,hlayer2node);
    edit3.Text:=inttostr(hlayer2node);
    //read layer input to hidden layer1
    for j:=1 to hlayer1node do begin
      for i:=1 to 2 do begin
        readln(filename3,w1old[j,i]);
        listbox3.Items.Add('W1['+inttostr(j)+','+inttostr(i)+'] = '+floattostr(w1old[j,i]));
      end;
    end;
    for j:=1 to hlayer1node do begin
      readln(filename3,t1old[j]);
      listbox3.Items.Add('Th1['+inttostr(j)+'] = '+floattostr(t1old[j]));
    end;
    //hidden layer 1 to h layer 2
    for k:=1 to hlayer2node do begin
      for j:=1 to hlayer1node do begin
        readln(filename3,w2old[k,j]);
        listbox4.Items.Add('W2['+inttostr(k)+','+inttostr(j)+'] = '+floattostr(w2old[k,j]));
      end;
    end;
    for k:=1 to hlayer2node do begin
      readln(filename3,t2old[k]);
      listbox4.Items.Add('Th2['+inttostr(k)+'] = '+floattostr(t2old[k]));
    end;
    //hidden layer 2 to output layer
    for l:=1 to kelas do begin
      for k:= 1 to hlayer2node do begin
        readln(filename3,w3old[l,k]);
        listbox5.Items.Add('W3['+inttostr(l)+','+inttostr(k)+'] = '+floattostr(w3old[l,k]));
      end;
    end;
    for l:=1 to kelas do begin
      readln(filename3,t3old[l]);
      listbox5.Items.Add('Th3['+inttostr(l)+'] = '+floattostr(t3old[l]));
    end;

  end;
  closefile(filename3);
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  showmessage('Multi-layer perceptron (c) 2019 Steven Seaver W | Biomedical Engineering Department, ITS');
end;

end.
