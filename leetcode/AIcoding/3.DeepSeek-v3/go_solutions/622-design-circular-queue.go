type MyCircularQueue struct {
    data []int
    head int
    tail int
    size int
    capacity int
}

func Constructor(k int) MyCircularQueue {
    return MyCircularQueue{
        data: make([]int, k),
        head: -1,
        tail: -1,
        size: 0,
        capacity: k,
    }
}

func (this *MyCircularQueue) EnQueue(value int) bool {
    if this.IsFull() {
        return false
    }
    if this.IsEmpty() {
        this.head = 0
    }
    this.tail = (this.tail + 1) % this.capacity
    this.data[this.tail] = value
    this.size++
    return true
}

func (this *MyCircularQueue) DeQueue() bool {
    if this.IsEmpty() {
        return false
    }
    if this.head == this.tail {
        this.head = -1
        this.tail = -1
    } else {
        this.head = (this.head + 1) % this.capacity
    }
    this.size--
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
    return this.data[this.tail]
}

func (this *MyCircularQueue) IsEmpty() bool {
    return this.size == 0
}

func (this *MyCircularQueue) IsFull() bool {
    return this.size == this.capacity
}