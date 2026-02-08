package leetcode

import (
	"fmt"
	"sync"
)

type FooBar struct {
	n int
	wg *sync.WaitGroup
	mutex *sync.Mutex
	flag bool
}

func (f *FooBar) Foo() {
	for i := 0; i < f.n; i++ {
		f.mutex.Lock()
		if f.flag {
			f.mutex.Unlock()
			continue
		}
		fmt.Print("Foo")
		f.flag = true
		f.mutex.Unlock()
		f.wg.Done()
	}
}

func (f *FooBar) Bar() {
	for i := 0; i < f.n; i++ {
		f.mutex.Lock()
		if !f.flag {
			f.mutex.Unlock()
			continue
		}
		fmt.Print("Bar")
		f.flag = false
		f.mutex.Unlock()
		f.wg.Done()
	}
}

func (f *FooBar) Call() {
	f.wg.Add(2 * f.n)
	for i := 0; i < f.n; i++ {
		go f.Foo()
		go f.Bar()
	}
	f.wg.Wait()
}

func NewFooBar(n int) *FooBar {
	return &FooBar{
		n: n,
		wg: &sync.WaitGroup{},
		mutex: &sync.Mutex{},
		flag: false,
	}
}