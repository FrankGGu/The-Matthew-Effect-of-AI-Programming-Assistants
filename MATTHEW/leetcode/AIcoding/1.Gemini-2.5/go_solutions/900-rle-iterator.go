type RLEIterator struct {
	arr []int
	ptr int
}

func Constructor(A []int) RLEIterator {
	return RLEIterator{arr: A, ptr: 0}
}

func (this *RLEIterator) Next(n int) int {
	for this.ptr < len(this.arr) {
		if this.arr[this.ptr] >= n {
			this.arr[this.ptr] -= n
			return this.arr[this.ptr+1]
		} else {
			n -= this.arr[this.ptr]
			this.ptr += 2
		}
	}
	return -1
}