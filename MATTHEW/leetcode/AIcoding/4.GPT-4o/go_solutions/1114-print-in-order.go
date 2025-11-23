type Foo struct {
    mu sync.Mutex
    cond1, cond2 *sync.Cond
    stage int
}

func Constructor() Foo {
    f := Foo{}
    f.cond1 = sync.NewCond(&f.mu)
    f.cond2 = sync.NewCond(&f.mu)
    f.stage = 0
    return f
}

func (this *Foo) First(printFirst func()) {
    this.mu.Lock()
    printFirst()
    this.stage = 1
    this.cond1.Broadcast()
    this.mu.Unlock()
}

func (this *Foo) Second(printSecond func()) {
    this.mu.Lock()
    for this.stage < 1 {
        this.cond1.Wait()
    }
    printSecond()
    this.stage = 2
    this.cond2.Broadcast()
    this.mu.Unlock()
}

func (this *Foo) Third(printThird func()) {
    this.mu.Lock()
    for this.stage < 2 {
        this.cond2.Wait()
    }
    printThird()
    this.mu.Unlock()
}