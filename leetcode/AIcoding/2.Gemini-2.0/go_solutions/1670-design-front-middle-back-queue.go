type FrontMiddleBackQueue struct {
	q []int
}

func Constructor() FrontMiddleBackQueue {
	return FrontMiddleBackQueue{q: []int{}}
}

func (this *FrontMiddleBackQueue) PushFront(val int) {
	this.q = append([]int{val}, this.q...)
}

func (this *FrontMiddleBackQueue) PushMiddle(val int) {
	mid := len(this.q) / 2
	this.q = append(this.q[:mid], append([]int{val}, this.q[mid:]...)...)
}

func (this *FrontMiddleBackQueue) PushBack(val int) {
	this.q = append(this.q, val)
}

func (this *FrontMiddleBackQueue) PopFront() int {
	if len(this.q) == 0 {
		return -1
	}
	val := this.q[0]
	this.q = this.q[1:]
	return val
}

func (this *FrontMiddleBackQueue) PopMiddle() int {
	if len(this.q) == 0 {
		return -1
	}
	mid := (len(this.q) - 1) / 2
	val := this.q[mid]
	this.q = append(this.q[:mid], this.q[mid+1:]...)
	return val
}

func (this *FrontMiddleBackQueue) PopBack() int {
	if len(this.q) == 0 {
		return -1
	}
	val := this.q[len(this.q)-1]
	this.q = this.q[:len(this.q)-1]
	return val
}