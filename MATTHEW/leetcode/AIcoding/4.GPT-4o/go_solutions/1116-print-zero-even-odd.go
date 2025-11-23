type ZeroEvenOdd struct {
	n      int
	oddCh  chan struct{}
	evenCh chan struct{}
	zeroCh chan struct{}
}

func Constructor(n int) ZeroEvenOdd {
	return ZeroEvenOdd{
		n:      n,
		oddCh:  make(chan struct{}),
		evenCh: make(chan struct{}),
		zeroCh: make(chan struct{}),
	}
}

func (zeo *ZeroEvenOdd) zero(printZero func()) {
	for i := 0; i < zeo.n; i++ {
		printZero()
		if i%2 == 0 {
			zeo.oddCh <- struct{}{}
		} else {
			zeo.evenCh <- struct{}{}
		}
	}
}

func (zeo *ZeroEvenOdd) odd(printOdd func()) {
	for i := 0; i < zeo.n; i++ {
		<-zeo.oddCh
		printOdd()
	}
}

func (zeo *ZeroEvenOdd) even(printEven func()) {
	for i := 0; i < zeo.n; i++ {
		<-zeo.evenCh
		printEven()
	}
}