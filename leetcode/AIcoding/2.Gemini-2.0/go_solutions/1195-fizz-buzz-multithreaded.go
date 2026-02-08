import (
	"fmt"
	"sync"
)

type FizzBuzz struct {
	n   int
	mu  sync.Mutex
	i   int
	f   chan int
	b   chan int
	fb  chan int
	num chan int
	wg  sync.WaitGroup
}

func NewFizzBuzz(n int) *FizzBuzz {
	fb := &FizzBuzz{
		n:   n,
		i:   1,
		f:   make(chan int, n),
		b:   make(chan int, n),
		fb:  make(chan int, n),
		num: make(chan int, n),
	}
	fb.wg.Add(4)
	return fb
}

func (this *FizzBuzz) Fizz(printFizz func()) {
	defer this.wg.Done()
	for i := range this.f {
		printFizz()
		this.mu.Lock()
		this.i++
		this.mu.Unlock()
	}
}

func (this *FizzBuzz) Buzz(printBuzz func()) {
	defer this.wg.Done()
	for i := range this.b {
		printBuzz()
		this.mu.Lock()
		this.i++
		this.mu.Unlock()
	}
}

func (this *FizzBuzz) Fizzbuzz(printFizzBuzz func()) {
	defer this.wg.Done()
	for i := range this.fb {
		printFizzBuzz()
		this.mu.Lock()
		this.i++
		this.mu.Unlock()
	}
}

func (this *FizzBuzz) Number(printNumber func(int)) {
	defer this.wg.Done()
	for i := range this.num {
		printNumber(i)
		this.mu.Lock()
		this.i++
		this.mu.Unlock()
	}
}

func (this *FizzBuzz) Run() {
	for i := 1; i <= this.n; i++ {
		if i%3 == 0 && i%5 == 0 {
			this.fb <- i
		} else if i%3 == 0 {
			this.f <- i
		} else if i%5 == 0 {
			this.b <- i
		} else {
			this.num <- i
		}
	}
	close(this.f)
	close(this.b)
	close(this.fb)
	close(this.num)
}