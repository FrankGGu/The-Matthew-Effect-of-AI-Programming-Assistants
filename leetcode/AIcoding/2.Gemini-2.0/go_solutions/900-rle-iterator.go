type RLEIterator struct {
	encoding []int
	index    int
	count    int
}

func Constructor(encoding []int) RLEIterator {
	return RLEIterator{encoding: encoding, index: 0, count: 0}
}

func (this *RLEIterator) Next(n int) int {
	for this.index < len(this.encoding) {
		if this.count == 0 {
			this.count = this.encoding[this.index]
		}

		if n <= this.count {
			this.count -= n
			return this.encoding[this.index+1]
		} else {
			n -= this.count
			this.count = 0
			this.index += 2
		}
	}

	return -1
}