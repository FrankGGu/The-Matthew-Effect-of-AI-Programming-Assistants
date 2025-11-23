package main

type MyCircularQueue struct {
    data []int
    capacity int
    front int
    rear int
}

func Constructor(k int) MyCircularQueue {
    return MyCircularQueue{
        data: make([]int, k),
        capacity: k,
        front: 0,
        rear: 0,
    }
}

func (this *MyCircularQueue) EnQueue(value int) bool {
    if this.IsFull() {
        return false
    }
    this.data[this.rear] = value
    this.rear = (this.rear + 1) % this.capacity
    return true
}

func (this *MyCircularQueue) DeQueue() bool {
    if this.IsEmpty() {
        return false
    }
    this.front = (this.front + 1) % this.capacity
    return true
}

func (this *MyCircularQueue) Front() int {
    if this.IsEmpty() {
        return -1
    }
    return this.data[this.front]
}

func (this *MyCircularQueue) Rear() int {
    if this.IsEmpty() {
        return -1
    }
    return this.data[(this.rear - 1 + this.capacity) % this.capacity]
}

func (this *MyCircularQueue) IsEmpty() bool {
    return this.front == this.rear
}

func (this *MyCircularQueue) IsFull() bool {
    return (this.rear + 1) % this.capacity == this.front
}