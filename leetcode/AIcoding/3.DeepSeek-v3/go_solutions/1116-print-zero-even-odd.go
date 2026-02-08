package main

import (
	"fmt"
	"sync"
)

type ZeroEvenOdd struct {
	n int
	zeroChan chan struct{}
	evenChan chan struct{}
	oddChan  chan struct{}
	wg       sync.WaitGroup
}

func NewZeroEvenOdd(n int) *ZeroEvenOdd {
	return &ZeroEvenOdd{
		n:        n,
		zeroChan: make(chan struct{}),
		evenChan: make(chan struct{}),
		oddChan:  make(chan struct{}),
	}
}

func (zeo *ZeroEvenOdd) Zero(printNumber func(int)) {
	defer zeo.wg.Done()
	for i := 1; i <= zeo.n; i++ {
		<-zeo.zeroChan
		printNumber(0)
		if i%2 == 1 {
			zeo.oddChan <- struct{}{}
		} else {
			zeo.evenChan <- struct{}{}
		}
	}
}

func (zeo *ZeroEvenOdd) Even(printNumber func(int)) {
	defer zeo.wg.Done()
	for i := 2; i <= zeo.n; i += 2 {
		<-zeo.evenChan
		printNumber(i)
		if i < zeo.n {
			zeo.zeroChan <- struct{}{}
		}
	}
}

func (zeo *ZeroEvenOdd) Odd(printNumber func(int)) {
	defer zeo.wg.Done()
	for i := 1; i <= zeo.n; i += 2 {
		<-zeo.oddChan
		printNumber(i)
		if i < zeo.n {
			zeo.zeroChan <- struct{}{}
		}
	}
}

func (zeo *ZeroEvenOdd) Start() {
	zeo.wg.Add(3)
	go zeo.Zero(printNumber)
	go zeo.Even(printNumber)
	go zeo.Odd(printNumber)
	zeo.zeroChan <- struct{}{}
	zeo.wg.Wait()
	close(zeo.zeroChan)
	close(zeo.evenChan)
	close(zeo.oddChan)
}

func printNumber(x int) {
	fmt.Print(x)
}

func main() {
	n := 5
	zeo := NewZeroEvenOdd(n)
	zeo.Start()
}