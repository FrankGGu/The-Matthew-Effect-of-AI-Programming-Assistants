type MyCircularQueue struct {
	queue []int
	head  int
	tail  int
	size  int
	count int
}

func Constructor(k int) MyCircularQueue {
	return MyCircularQueue{
		queue: make([]int, k),
		head:  0,
		tail:  0,
		size:  k,
		count: 0,
	}
}

func (this *MyCircularQueue) EnQueue(value int) bool {
	if this.IsFull() {
		return false
	}
	this.queue[this.tail] = value
	this.tail = (this.tail + 1) % this.size
	this.count++
	return true
}

func (this *MyCircularQueue) DeQueue() bool {
	if this.IsEmpty() {
		return false
	}
	this.head = (this.head + 1) % this.size
	this.count--
	return true
}

func (this *MyCircularQueue) Front() int {
	if this.IsEmpty() {
		return -1
	}
	return this.queue[this.head]
}

func (this *MyCircularQueue) Rear() int {
	if this.IsEmpty() {
		return -1
	}
	return this.queue[(this.tail-1+this.size)%this.size]
}

func (this *MyCircularQueue) IsEmpty() bool {
	return this.count == 0
}

func (this *MyCircularQueue) IsFull() bool {
	return this.count == this.size
}