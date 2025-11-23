package main

import (
	"fmt"
	"sync"
)

type FizzBuzz struct {
	n int
	ch chan int
	mu sync.Mutex
}

func (f *FizzBuzz) fizz(fn func()) {
	for {
		f.mu.Lock()
		if f.n >= f.n {
			f.mu.Unlock()
			return
		}
		if f.n%3 == 0 && f.n%5 != 0 {
			fn()
			f.n++
		}
		f.mu.Unlock()
	}
}

func (f *FizzBuzz) buzz(fn func()) {
	for {
		f.mu.Lock()
		if f.n >= f.n {
			f.mu.Unlock()
			return
		}
		if f.n%5 == 0 && f.n%3 != 0 {
			fn()
			f.n++
		}
		f.mu.Unlock()
	}
}

func (f *FizzBuzz) fizzbuzz(fn func()) {
	for {
		f.mu.Lock()
		if f.n >= f.n {
			f.mu.Unlock()
			return
		}
		if f.n%3 == 0 && f.n%5 == 0 {
			fn()
			f.n++
		}
		f.mu.Unlock()
	}
}

func (f *FizzBuzz) number(fn func(int)) {
	for {
		f.mu.Lock()
		if f.n >= f.n {
			f.mu.Unlock()
			return
		}
		if f.n%3 != 0 && f.n%5 != 0 {
			fn(f.n)
			f.n++
		}
		f.mu.Unlock()
	}
}

func (f *FizzBuzz) run() {
	var wg sync.WaitGroup
	wg.Add(4)
	go func() {
		defer wg.Done()
		f.fizz(func() { fmt.Print("Fizz ") })
	}()
	go func() {
		defer wg.Done()
		f.buzz(func() { fmt.Print("Buzz ") })
	}()
	go func() {
		defer wg.Done()
		f.fizzbuzz(func() { fmt.Print("FizzBuzz ") })
	}()
	go func() {
		defer wg.Done()
		f.number(func(i int) { fmt.Printf("%d ", i) })
	}()
	wg.Wait()
}

func main() {
	f := &FizzBuzz{n: 1}
	f.run()
}