import "fmt"
import "sync"
import "runtime"

type ZeroEvenOdd struct {
	n         int
	zeroChan  chan int
	evenChan  chan int
	oddChan   chan int
	closeChan chan bool
}

func NewZeroEvenOdd(n int) *ZeroEvenOdd {
	return &ZeroEvenOdd{
		n:         n,
		zeroChan:  make(chan int, 1),
		evenChan:  make(chan int),
		oddChan:   make(chan int),
		closeChan: make(chan bool),
	}
}

func (this *ZeroEvenOdd) Zero(printNumber func(int)) {
	for i := 0; i < this.n; i++ {
		<-this.zeroChan
		printNumber(0)
		if (i+1)%2 == 0 {
			this.evenChan <- i + 1
		} else {
			this.oddChan <- i + 1
		}
	}
	this.closeChan <- true
}

func (this *ZeroEvenOdd) Even(printNumber func(int)) {
	for {
		select {
		case i := <-this.evenChan:
			printNumber(i)
			this.zeroChan <- i
		case <-this.closeChan:
			return
		}
	}
}

func (this *ZeroEvenOdd) Odd(printNumber func(int)) {
	for {
		select {
		case i := <-this.oddChan:
			printNumber(i)
			this.zeroChan <- i
		case <-this.closeChan:
			return
		}
	}
}