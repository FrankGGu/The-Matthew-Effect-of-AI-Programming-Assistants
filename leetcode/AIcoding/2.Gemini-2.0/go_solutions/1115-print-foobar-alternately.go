import "sync"

type FooBar struct {
	n   int
	foo chan struct{}
	bar chan struct{}
}

func NewFooBar(n int) *FooBar {
	fb := &FooBar{
		n:   n,
		foo: make(chan struct{}, 1),
		bar: make(chan struct{}, 1),
	}
	fb.foo <- struct{}{}
	return fb
}

func (this *FooBar) Foo(printFoo func()) {
	for i := 0; i < this.n; i++ {
		<-this.foo
		printFoo()
		this.bar <- struct{}{}
	}
}

func (this *FooBar) Bar(printBar func()) {
	for i := 0; i < this.n; i++ {
		<-this.bar
		printBar()
		this.foo <- struct{}{}
	}
}