type MyCircularDeque struct {
	data     []int
	front    int
	rear     int
	capacity int
}

func Constructor(k int) MyCircularDeque {
	return MyCircularDeque{
		data:     make([]int, k+1),
		front:    0,
		rear:     0,
		capacity: k,
	}
}

func (this *MyCircularDeque) InsertFront(value int) bool {
	if this.IsFull() {
		return false
	}
	this.front = (this.front - 1 + this.capacity + 1) % (this.capacity + 1)
	this.data[this.front] = value
	return true
}

func (this *MyCircularDeque) InsertLast(value int) bool {
	if this.IsFull() {
		return false
	}
	this.data[this.rear] = value
	this.rear = (this.rear + 1) % (this.capacity + 1)
	return true
}

func (this *MyCircularDeque) DeleteFront() bool {
	if this.IsEmpty() {
		return false
	}
	this.front = (this.front + 1) % (this.capacity + 1)
	return true
}

func (this *MyCircularDeque) DeleteLast() bool {
	if this.IsEmpty() {
		return false
	}
	this.rear = (this.rear - 1 + this.capacity + 1) % (this.capacity + 1)
	return true
}

func (this *MyCircularDeque) GetFront() int {
	if this.IsEmpty() {
		return -1
	}
	return this.data[this.front]
}

func (this *MyCircularDeque) GetRear() int {
	if this.IsEmpty() {
		return -1
	}
	return this.data[(this.rear - 1 + this.capacity + 1) % (this.capacity + 1)]
}

func (this *MyCircularDeque) IsEmpty() bool {
	return this.front == this.rear
}

func (this *MyCircularDeque) IsFull() bool {
	return (this.rear + 1) % (this.capacity + 1) == this.front
}