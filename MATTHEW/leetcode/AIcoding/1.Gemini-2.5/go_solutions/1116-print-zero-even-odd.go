type ZeroEvenOdd struct {
	n int
	zeroChan chan struct{}
	oddChan chan struct{}
	evenChan chan struct{}
	currentNum int
}

func Constructor(n int) *ZeroEvenOdd {
	z := &ZeroEvenOdd{
		n: n,
		zeroChan: make(chan struct{}, 1), // Buffered to allow the initial signal
		oddChan: make(chan struct{}),
		evenChan: make(chan struct{}),
		currentNum: 1,
	}
	z.zeroChan <- struct{}{} // Initial signal to start printing zero
	return z
}

func (z *ZeroEvenOdd) zero(printNumber func(int)) {
	for {
		<-z.zeroChan // Wait for signal to print 0

		if z.currentNum > z.n { // All numbers processed, exit
			break
		}

		printNumber(0)

		if z.currentNum%2 == 1 { // If the next number to print is odd
			z.oddChan <- struct{}{}
		} else { // If the next number to print is even
			z.evenChan <- struct{}{}
		}
	}
}

func (z *ZeroEvenOdd) even(printNumber func(int)) {
	for i := 0; i < z.n/2; i++ { // Loop for n/2 even numbers
		<-z.evenChan // Wait for signal to print even
		printNumber(z.currentNum)
		z.currentNum++
		z.zeroChan <- struct{}{} // Signal zero to print next 0
	}
}

func (z *ZeroEvenOdd) odd(printNumber func(int)) {
	for i := 0; i < (z.n+1)/2; i++ { // Loop for (n+1)/2 odd numbers
		<-z.oddChan // Wait for signal to print odd
		printNumber(z.currentNum)
		z.currentNum++
		z.zeroChan <- struct{}{} // Signal zero to print next 0
	}
}