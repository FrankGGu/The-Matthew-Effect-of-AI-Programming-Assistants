type Foo struct {
    firstDone  chan struct{}
    secondDone chan struct{}
}

func NewFoo() *Foo {
    return &Foo{
        firstDone:  make(chan struct{}),
        secondDone: make(chan struct{}),
    }
}

func (f *Foo) First(printFirst func()) {
    printFirst()
    close(f.firstDone)
}

func (f *Foo) Second(printSecond func()) {
    <-f.firstDone
    printSecond()
    close(f.secondDone)
}

func (f *Foo) Third(printThird func()) {
    <-f.secondDone
    printThird()
}