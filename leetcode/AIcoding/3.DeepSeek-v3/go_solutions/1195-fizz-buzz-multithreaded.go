type FizzBuzz struct {
    n int
    fizzChan chan struct{}
    buzzChan chan struct{}
    fizzbuzzChan chan struct{}
    numberChan chan struct{}
    wg sync.WaitGroup
}

func NewFizzBuzz(n int) *FizzBuzz {
    fb := &FizzBuzz{
        n: n,
        fizzChan: make(chan struct{}),
        buzzChan: make(chan struct{}),
        fizzbuzzChan: make(chan struct{}),
        numberChan: make(chan struct{}),
    }
    fb.wg.Add(4)
    return fb
}

func (fb *FizzBuzz) fizz(printFizz func()) {
    defer fb.wg.Done()
    for i := 1; i <= fb.n; i++ {
        select {
        case <-fb.fizzChan:
            if i%3 == 0 && i%5 != 0 {
                printFizz()
            }
        }
    }
}

func (fb *FizzBuzz) buzz(printBuzz func()) {
    defer fb.wg.Done()
    for i := 1; i <= fb.n; i++ {
        select {
        case <-fb.buzzChan:
            if i%5 == 0 && i%3 != 0 {
                printBuzz()
            }
        }
    }
}

func (fb *FizzBuzz) fizzbuzz(printFizzBuzz func()) {
    defer fb.wg.Done()
    for i := 1; i <= fb.n; i++ {
        select {
        case <-fb.fizzbuzzChan:
            if i%15 == 0 {
                printFizzBuzz()
            }
        }
    }
}

func (fb *FizzBuzz) number(printNumber func(int)) {
    defer fb.wg.Done()
    for i := 1; i <= fb.n; i++ {
        select {
        case <-fb.numberChan:
            if i%3 != 0 && i%5 != 0 {
                printNumber(i)
            }
        }
    }
}

func (fb *FizzBuzz) start() {
    for i := 1; i <= fb.n; i++ {
        switch {
        case i%15 == 0:
            fb.fizzbuzzChan <- struct{}{}
        case i%3 == 0:
            fb.fizzChan <- struct{}{}
        case i%5 == 0:
            fb.buzzChan <- struct{}{}
        default:
            fb.numberChan <- struct{}{}
        }
    }
}

func (fb *FizzBuzz) Wait() {
    fb.wg.Wait()
}