import "sync"

type Foo struct {
	firstDone  chan bool
	secondDone chan bool
}

func NewFoo() *Foo {
	return &Foo{
		firstDone:  make(chan bool),
		secondDone: make(chan bool),
	}
}

func (this *Foo) First(printFirst func()) {
	printFirst()
	close(this.firstDone)
}

func (this *Foo) Second(printSecond func()) {
	<-this.firstDone
	printSecond()
	close(this.secondDone)
}

func (this *Foo) Third(printThird func()) {
	<-this.secondDone
	printThird()
}