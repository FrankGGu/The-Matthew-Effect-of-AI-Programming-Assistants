type MyCircularDeque struct {
    data []int
    size int
    cap  int
    front int
    rear int
}

func Constructor(k int) MyCircularDeque {
    return MyCircularDeque{
        data: make([]int, k),
        size: 0,
        cap: k,
        front: 0,
        rear: 0,
    }
}

func (this *MyCircularDeque) InsertFront(value int) bool {
    if this.IsFull() {
        return false
    }
    this.front = (this.front - 1 + this.cap) % this.cap
    this.data[this.front] = value
    this.size++
    return true
}

func (this *MyCircularDeque) InsertLast(value int) bool {
    if this.IsFull() {
        return false
    }
    this.data[this.rear] = value
    this.rear = (this.rear + 1) % this.cap
    this.size++
    return true
}

func (this *MyCircularDeque) DeleteFront() bool {
    if this.IsEmpty() {
        return false
    }
    this.front = (this.front + 1) % this.cap
    this.size--
    return true
}

func (this *MyCircularDeque) DeleteLast() bool {
    if this.IsEmpty() {
        return false
    }
    this.rear = (this.rear - 1 + this.cap) % this.cap
    this.size--
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
    return this.data[(this.rear - 1 + this.cap) % this.cap]
}

func (this *MyCircularDeque) IsEmpty() bool {
    return this.size == 0
}

func (this *MyCircularDeque) IsFull() bool {
    return this.size == this.cap
}