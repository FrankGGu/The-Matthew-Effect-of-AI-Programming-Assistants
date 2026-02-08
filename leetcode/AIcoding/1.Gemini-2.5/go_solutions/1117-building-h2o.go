import (
	"sync"
)

type H2O struct {
	hCh chan struct{}
	oCh chan struct{}
	wg  sync.WaitGroup
}

func NewH2O() *H2O {
	h2o := &H2O{
		hCh: make(chan struct{}, 2),
		oCh: make(chan struct{}, 1),
	}
	h2o.wg.Add(3)
	go h2o.release()
	return h2o
}

func (h2o *H2O) release() {
	h2o.wg.Wait()
	h2o.wg.Add(3)
	h2o.hCh <- struct{}{}
	h2o.hCh <- struct{}{}
	h2o.oCh <- struct{}{}
}

func (h2o *H2O) hydrogen(releaseHydrogen func()) {
	<-h2o.hCh
	releaseHydrogen()
	h2o.wg.Done()
}

func (h2o *H2O) oxygen(releaseOxygen func()) {
	<-h2o.oCh
	releaseOxygen()
	h2o.wg.Done()
}