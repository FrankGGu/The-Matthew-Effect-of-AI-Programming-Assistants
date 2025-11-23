type FizzBuzz struct {
	n int

	fizzReq     chan struct{}
	buzzReq     chan struct{}
	fizzBuzzReq chan struct{}
	numberReq   chan int

	ack chan struct{}

	done chan struct{}
}

func Constructor(n int) *FizzBuzz {
	fb := &FizzBuzz{
		n: n,
		fizzReq:     make(chan struct{}),
		buzzReq:     make(chan struct{}),
		fizzBuzzReq: make(chan struct{}),
		numberReq:   make(chan int),
		ack:         make(chan struct{}),
		done:        make(chan struct{}),
	}

	go func() {
		for i := 1; i <= fb.n; i++ {
			if i%15 == 0 {
				fb.fizzBuzzReq <- struct{}{}
			} else if i%3 == 0 {
				fb.fizzReq <- struct{}{}
			} else if i%5 == 0 {
				fb.buzzReq <- struct{}{}
			} else {
				fb.numberReq <- i
			}
			<-fb.ack
		}
		close(fb.done)
	}()

	return fb
}

func (fb *FizzBuzz) fizz(printFizz func()) {
	for {
		select {
		case <-fb.fizzReq:
			printFizz()
			fb.ack <- struct{}{}
		case <-fb.done:
			return
		}
	}
}

func (fb *FizzBuzz) buzz(printBuzz func()) {
	for {
		select {
		case <-fb.buzzReq:
			printBuzz()
			fb.ack <- struct{}{}
		case <-fb.done:
			return
		}
	}
}

func (fb *FizzBuzz) fizzbuzz(printFizzBuzz func()) {
	for {
		select {
		case <-fb.fizzBuzzReq:
			printFizzBuzz()
			fb.ack <- struct{}{}
		case <-fb.done:
			return
		}
	}
}

func (fb *FizzBuzz) number(printNumber func(int)) {
	for {
		select {
		case num := <-fb.numberReq:
			printNumber(num)
			fb.ack <- struct{}{}
		case <-fb.done:
			return
		}
	}
}