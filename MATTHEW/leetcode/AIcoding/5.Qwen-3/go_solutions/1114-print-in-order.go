package main

type Foo struct {
	ch1 chan struct{}
	ch2 chan struct{}
}

func (f *Foo) first() {
	// do something
	close(f.ch1)
}

func (f *Foo) second() {
	<-f.ch1
	// do something
	close(f.ch2)
}

func (f *Foo) third() {
	<-f.ch2
	// do something
}

func newFoo() *Foo {
	return &Foo{
		ch1: make(chan struct{}),
		ch2: make(chan struct{}),
	}
}

func (f *Foo) PrintInOrder(fn func()) {
	fn()
}