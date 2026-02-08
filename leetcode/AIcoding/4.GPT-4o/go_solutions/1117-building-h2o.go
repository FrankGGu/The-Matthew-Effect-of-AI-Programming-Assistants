type H2O struct {
    hCount, oCount int
    hCond, oCond   chan struct{}
}

func Constructor() H2O {
    return H2O{
        hCount: 0,
        oCount: 0,
        hCond:  make(chan struct{}, 2),
        oCond:  make(chan struct{}, 1),
    }
}

func (this *H2O) Hydrogen(releaseHydrogen func()) {
    releaseHydrogen()
    this.hCond <- struct{}{}
    this.hCount++
    if this.hCount == 2 && this.oCount > 0 {
        <-this.oCond
        <-this.oCond
        this.hCount = 0
        this.oCount = 0
    }
}

func (this *H2O) Oxygen(releaseOxygen func()) {
    releaseOxygen()
    this.oCond <- struct{}{}
    this.oCount++
    if this.oCount == 1 && this.hCount >= 2 {
        <-this.hCond
        <-this.hCond
        this.hCount = 0
        this.oCount = 0
    }
}