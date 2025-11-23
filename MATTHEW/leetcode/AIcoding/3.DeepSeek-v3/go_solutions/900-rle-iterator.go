type RLEIterator struct {
    encoded []int
    index   int
}

func Constructor(encoding []int) RLEIterator {
    return RLEIterator{encoded: encoding, index: 0}
}

func (this *RLEIterator) Next(n int) int {
    for this.index < len(this.encoded) {
        if this.encoded[this.index] >= n {
            this.encoded[this.index] -= n
            return this.encoded[this.index+1]
        } else {
            n -= this.encoded[this.index]
            this.index += 2
        }
    }
    return -1
}