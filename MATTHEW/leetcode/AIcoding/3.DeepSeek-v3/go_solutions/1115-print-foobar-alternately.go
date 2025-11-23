package main

import (
	"fmt"
	"sync"
)

type FooBar struct {
	n int
	fooChan chan struct{}
	barChan chan struct{}
}

func NewFooBar(n int) *FooBar {
	return &FooBar{
		n: n,
		fooChan: make(chan struct{}, 1),
		barChan: make(chan struct{}, 1),
	}
}

func (fb *FooBar) foo(printFoo func()) {
	for i := 0; i < fb.n; i++ {
		<-fb.fooChan
		printFoo()
		fb.barChan <- struct{}{}
	}
}

func (fb *FooBar) bar(printBar func()) {
	for i := 0; i < fb.n; i++ {
		<-fb.barChan
		printBar()
		fb.fooChan <- struct{}{}
	}
}

func main() {
	var wg sync.WaitGroup
	n := 5
	fb := NewFooBar(n)
	wg.Add(2)

	go func() {
		defer wg.Done()
		fb.foo(func() { fmt.Print("foo") })
	}()

	go func() {
		defer wg.Done()
		fb.bar(func() { fmt.Print("bar") })
	}()

	fb.fooChan <- struct{}{}
	wg.Wait()
}