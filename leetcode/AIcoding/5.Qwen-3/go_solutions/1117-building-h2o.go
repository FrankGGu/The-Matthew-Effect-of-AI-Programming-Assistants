package main

type H2O struct {
	hChan chan struct{}
	oChan chan struct{}
}

func Constructor() H2O {
	return H2O{
		hChan: make(chan struct{}, 2),
		oChan: make(chan struct{}, 1),
	}
}

func (h2o *H2O) Hydrogen(f func()) {
	<-h2o.hChan
	f()
	h2o.oChan <- struct{}{}
}

func (h2o *H2O) Oxygen(f func()) {
	<-h2o.oChan
	f()
	h2o.hChan <- struct{}{}
	 h2o.hChan <- struct{}{}
}