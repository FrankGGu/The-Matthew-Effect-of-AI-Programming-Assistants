type MyCircularDeque struct {
    data []int
    front int
    rear int
    size int
    capacity int
}

func Constructor(k int) MyCircularDeque {
    return MyCircularDeque{
        data: make([]int, k),
        front: 0,
        rear: 0,
        size: 0,
        capacity: k,
    }
}

func (this *MyCircularDeque) InsertFront(value int) bool {
    if this.size == this.capacity {
        return false
    }
    this.front = (this.front - 1 + this.capacity) % this.capacity
    this.data[this.front] = value
    this.size++
    return true
}

func (this *MyCircularDeque) InsertLast(value int) bool {
    if this.size == this.capacity {
        return false
    }
    this.data[this.rear] = value
    this.rear = (this.rear + 1) % this.capacity
    this.size++
    return true
}

func (this *MyCircularDeque) DeleteFront() bool {
    if this.size == 0 {
        return false
    }
    this.front = (this.front + 1) % this.capacity
    this.size--
    return true
}

func (this *MyCircularDeque) DeleteLast() bool {
    if this.size == 0 {
        return false
    }
    this.rear = (this.rear - 1 + this.capacity) % this.capacity
    this.size--
    return true
}

func (this *MyCircularDeque) GetFront() int {
    if this.size == 0 {
        return -1
    }
    return this.data[this.front]
}

func (this *MyCircularDeque) GetRear() int {
    if this.size == 0 {
        return -1
    }
    return this.data[(this.rear - 1 + this.capacity) % this.capacity]
}

func (this *MyCircularDeque) IsEmpty() bool {
    return this.size == 0
}

func (this *MyCircularDeque) IsFull() bool {
    return this.size == this.capacity
}