import "sync"

type H2O struct {
	h chan struct{}
	o chan struct{}
	wg *sync.WaitGroup
}

func NewH2O() *H2O {
	return &H2O{
		h: make(chan struct{}, 2),
		o: make(chan struct{}, 1),
		wg: &sync.WaitGroup{},
	}
}

func (h2o *H2O) Hydrogen(releaseHydrogen func()) {
	h2o.wg.Add(1)
	<-h2o.h
	releaseHydrogen()
	h2o.o <- struct{}{}
	h2o.wg.Done()
}

func (h2o *H2O) Oxygen(releaseOxygen func()) {
	h2o.wg.Add(1)
	<-h2o.o
	releaseOxygen()
	h2o.h <- struct{}{}
	h2o.h <- struct{}{}
	h2o.wg.Done()
}