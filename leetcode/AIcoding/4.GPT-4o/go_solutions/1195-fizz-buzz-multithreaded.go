package main

import (
	"fmt"
	"sync"
)

type FizzBuzz struct {
	n    int
	mutex sync.Mutex
	fizz  chan struct{}
	buzz  chan struct{}
	fizzbuzz chan struct{}
	number chan int
}

func Constructor(n int) FizzBuzz {
	return FizzBuzz{
		n:        n,
		fizz:     make(chan struct{}),
		buzz:     make(chan struct{}),
		fizzbuzz: make(chan struct{}),
		number:   make(chan int),
	}
}

func (fb *FizzBuzz) Fizz(printFizz func()) {
	for i := 1; i <= fb.n; i++ {
		if i%3 == 0 && i%5 != 0 {
			fb.fizz <- struct{}{}
			printFizz()
		}
	}
}

func (fb *FizzBuzz) Buzz(printBuzz func()) {
	for i := 1; i <= fb.n; i++ {
		if i%5 == 0 && i%3 != 0 {
			fb.buzz <- struct{}{}
			printBuzz()
		}
	}
}

func (fb *FizzBuzz) Fizzbuzz(printFizzBuzz func()) {
	for i := 1; i <= fb.n; i++ {
		if i%15 == 0 {
			fb.fizzbuzz <- struct{}{}
			printFizzBuzz()
		}
	}
}

func (fb *FizzBuzz) Number(printNumber func(x int)) {
	for i := 1; i <= fb.n; i++ {
		if i%3 != 0 && i%5 != 0 {
			printNumber(i)
		}
	}
}

func (fb *FizzBuzz) Run(printFizz func(), printBuzz func(), printFizzBuzz func(), printNumber func(x int)) {
	var wg sync.WaitGroup
	wg.Add(4)

	go func() {
		defer wg.Done()
		fb.Fizz(printFizz)
	}()

	go func() {
		defer wg.Done()
		fb.Buzz(printBuzz)
	}()

	go func() {
		defer wg.Done()
		fb.Fizzbuzz(printFizzBuzz)
	}()

	go func() {
		defer wg.Done()
		fb.Number(printNumber)
	}()

	go func() {
		for i := 1; i <= fb.n; i++ {
			select {
			case <-fb.fizz:
			case <-fb.buzz:
			case <-fb.fizzbuzz:
				continue
			default:
				printNumber(i)
			}
		}
	}()

	wg.Wait()
}

func main() {
	n := 15
	fb := Constructor(n)
	go fb.Run(
		func() { fmt.Println("fizz") },
		func() { fmt.Println("buzz") },
		func() { fmt.Println("fizzbuzz") },
		func(x int) { fmt.Println(x) },
	)
}