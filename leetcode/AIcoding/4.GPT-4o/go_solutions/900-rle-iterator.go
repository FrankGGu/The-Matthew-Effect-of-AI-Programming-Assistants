type RLEIterator struct {
    encoding []int
    index    int
    count    int
}

func Constructor(A []int) RLEIterator {
    return RLEIterator{encoding: A, index: 0, count: 0}
}

func (this *RLEIterator) Next(n int) int {
    for n > 0 {
        if this.index >= len(this.encoding) {
            return -1
        }
        if this.count == 0 {
            this.count = this.encoding[this.index]
            this.index++
        }
        if n > this.count {
            n -= this.count
            this.count = 0
        } else {
            this.count -= n
            return this.encoding[this.index]
        }
        this.index++
    }
    return -1
}

func (this *RLEIterator) HasNext() bool {
    return this.index < len(this.encoding) && (this.count > 0 || this.index+1 < len(this.encoding))
}