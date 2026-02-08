package main

type CircularDeque struct {
    capacity int
    front    int
    rear     int
    data     []int
}

func Constructor(maxSize int) CircularDeque {
    return CircularDeque{
        capacity: maxSize,
        front:    0,
        rear:     0,
        data:     make([]int, maxSize),
    }
}

func (this *CircularDeque) InsertFront(value int) bool {
    if this.IsFull() {
        return false
    }
    this.front = (this.front - 1 + this.capacity) % this.capacity
    this.data[this.front] = value
    return true
}

func (this *CircularDeque) InsertLast(value int) bool {
    if this.IsFull() {
        return false
    }
    this.data[this.rear] = value
    this.rear = (this.rear + 1) % this.capacity
    return true
}

func (this *CircularDeque) DeleteFront() bool {
    if this.IsEmpty() {
        return false
    }
    this.front = (this.front + 1) % this.capacity
    return true
}

func (this *CircularDeque) DeleteLast() bool {
    if this.IsEmpty() {
        return false
    }
    this.rear = (this.rear - 1 + this.capacity) % this.capacity
    return true
}

func (this *CircularDeque) GetFront() int {
    if this.IsEmpty() {
        return -1
    }
    return this.data[this.front]
}

func (this *CircularDeque) GetRear() int {
    if this.IsEmpty() {
        return -1
    }
    return this.data[(this.rear - 1 + this.capacity) % this.capacity]
}

func (this *CircularDeque) IsEmpty() bool {
    return this.front == this.rear
}

func (this *CircularDeque) IsFull() bool {
    return (this.rear + 1) % this.capacity == this.front
}