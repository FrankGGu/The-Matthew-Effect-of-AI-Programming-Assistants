type Accumulator struct {
    total int
}

func Constructor() Accumulator {
    return Accumulator{total: 0}
}

func (this *Accumulator) Add(num int) {
    this.total += num
}

func (this *Accumulator) GetTotal() int {
    return this.total
}