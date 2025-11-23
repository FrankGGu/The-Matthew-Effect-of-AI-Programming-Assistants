type MyCircularQueue struct {
	data     []int
	head     int
	tail     int
	capacity int
	count    int
}

func Constructor(k int) MyCircularQueue {
	return MyCircularQueue{
		data:     make([]int, k),
		head:     0,
		tail:     0,
		capacity: k,
		count:    0,
	}
}

func (this *MyCircularQueue) EnQueue(value int) bool {
	if this.IsFull() {
		return false
	}
	this.data[this.tail] = value
	this.tail = (this.tail + 1) % this.capacity
	this.count++
	return true
}

func (this *MyCircularQueue) DeQueue() bool {
	if this.IsEmpty() {
		return false
	}
	this.head = (this.head + 1) % this.capacity
	this.count--
	return true
}

func (this *MyCircularQueue) Front() int {
	if this.IsEmpty() {
		return -1
	}
	return this.data[this.head]
}

func (this *MyCircularQueue) Rear() int {
	if this.IsEmpty() {
		return -1
	}
	// The tail pointer points to the position where the next element will be inserted.
	// So, the last element inserted is at (tail - 1) % capacity.
	// We add capacity before modulo to handle the case where tail is 0.
	return this.data[(this.tail-1+this.capacity)%this.capacity]
}

func (this *MyCircularQueue) IsEmpty() bool {
	return this.count == 0
}

func (this *MyCircularQueue) IsFull() bool {
	return this.count == this.capacity
}