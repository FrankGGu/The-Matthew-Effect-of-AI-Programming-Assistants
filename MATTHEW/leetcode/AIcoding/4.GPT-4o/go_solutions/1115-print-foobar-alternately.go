type FooBar struct {
    n int
    ch1 chan struct{}
    ch2 chan struct{}
}

func Constructor(n int) FooBar {
    return FooBar{n: n, ch1: make(chan struct{}), ch2: make(chan struct{})}
}

func (this *FooBar) Foo(printFoo func()) {
    for i := 0; i < this.n; i++ {
        printFoo()
        this.ch1 <- struct{}{}
        <-this.ch2
    }
}

func (this *FooBar) Bar(printBar func()) {
    for i := 0; i < this.n; i++ {
        <-this.ch1
        printBar()
        this.ch2 <- struct{}{}
    }
}