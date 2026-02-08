type MyCircularQueue struct {
    data    []int
    head    int
    tail    int
    size    int
    capacity int
}

func Constructor(k int) MyCircularQueue {
    return MyCircularQueue{
        data:    make([]int, k),
        head:    0,
        tail:    0,
        size:    0,
        capacity: k,
    }
}

func (this *MyCircularQueue) InsertLast(value int) bool {
    if this.size == this.capacity {
        return false
    }
    this.data[this.tail] = value
    this.tail = (this.tail + 1) % this.capacity
    this.size++
    return true
}

func (this *MyCircularQueue) DeleteFront() bool {
    if this.size == 0 {
        return false
    }
    this.head = (this.head + 1) % this.capacity
    this.size--
    return true
}

func (this *MyCircularQueue) GetFront() int {
    if this.size == 0 {
        return -1
    }
    return this.data[this.head]
}

func (this *MyCircularQueue) GetRear() int {
    if this.size == 0 {
        return -1
    }
    return this.data[(this.tail-1+this.capacity)%this.capacity]
}

func (this *MyCircularQueue) IsEmpty() bool {
    return this.size == 0
}

func (this *MyCircularQueue) IsFull() bool {
    return this.size == this.capacity
}