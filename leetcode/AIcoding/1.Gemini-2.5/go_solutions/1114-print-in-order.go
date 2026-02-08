package main

import "sync"

type Foo struct {
	wg1 sync.WaitGroup
	wg2 sync.WaitGroup
}

func NewFoo() *Foo {
	f := &Foo{}
	f.wg1.Add(1)
	f.wg2.Add(1)
	return f
}

func (f *Foo) First(printFirst func()) {
	printFirst()
	f.wg1.Done()
}

func (f *Foo) Second(printSecond func()) {
	f.wg1.Wait()
	printSecond()
	f.wg2.Done()
}

func (f *Foo) Third(printThird func()) {
	f.wg2.Wait()
	printThird()
}