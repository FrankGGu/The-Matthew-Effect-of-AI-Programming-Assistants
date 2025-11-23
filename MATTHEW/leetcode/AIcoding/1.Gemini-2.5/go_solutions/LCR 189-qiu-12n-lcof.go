type Accumulator struct {
	sum int
}

func Constructor() Accumulator {
	return Accumulator{
		sum: 0,
	}
}

func (this *Accumulator) Add(val int) {
	this.sum += val
}

func (this *Accumulator) GetSum() int {
	return this.sum
}