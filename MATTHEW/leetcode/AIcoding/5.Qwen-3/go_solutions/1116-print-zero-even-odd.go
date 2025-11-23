package main

import (
	"bufio"
	"fmt"
	"os"
	"sync"
)

type ZeroEvenOdd struct {
	n int
	ch0 chan int
	ch1 chan int
	ch2 chan int
	wg  *sync.WaitGroup
}

func (z *ZeroEvenOdd) zero() {
	for i := 0; i < z.n; i++ {
		<-z.ch0
		fmt.Print(0)
		z.ch1 <- 1
	}
	z.wg.Done()
}

func (z *ZeroEvenOdd) even() {
	for i := 0; i < z.n/2; i++ {
		<-z.ch1
		fmt.Print(2*(i+1))
		z.ch2 <- 1
	}
	z.wg.Done()
}

func (z *ZeroEvenOdd) odd() {
	for i := 0; i < z.n/2; i++ {
		<-z.ch2
		fmt.Print(2*i+1)
		z.ch0 <- 1
	}
	z.wg.Done()
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Scan()
	n, _ := fmt.Sscanf(scanner.Text(), "%d", &n)
	z := &ZeroEvenOdd{n: n, ch0: make(chan int), ch1: make(chan int), ch2: make(chan int), wg: &sync.WaitGroup{}}
	z.wg.Add(3)
	go z.zero()
	go z.even()
	go z.odd()
	z.ch0 <- 1
	z.wg.Wait()
}