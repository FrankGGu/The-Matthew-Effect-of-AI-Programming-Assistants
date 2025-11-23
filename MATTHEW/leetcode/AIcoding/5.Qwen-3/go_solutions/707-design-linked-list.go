package main

type MyLinkedList struct {
    size int
    head *ListNode
}

func Constructor() MyLinkedList {
    return MyLinkedList{
        size: 0,
        head: &ListNode{},
    }
}

func (this *MyLinkedList) Get(index int) int {
    if index < 0 || index >= this.size {
        return -1
    }
    current := this.head
    for i := 0; i <= index; i++ {
        current = current.Next
    }
    return current.Val
}

func (this *MyLinkedList) AddAtHead(val int) {
    this.AddAtIndex(0, val)
}

func (this *MyLinkedList) AddAtTail(val int) {
    this.AddAtIndex(this.size, val)
}

func (this *MyLinkedList) AddAtIndex(index int, val int) {
    if index > this.size {
        return
    }
    prev := this.head
    for i := 0; i < index; i++ {
        prev = prev.Next
    }
    node := &ListNode{
        Val: val,
        Next: prev.Next,
    }
    prev.Next = node
    this.size++
}

func (this *MyLinkedList) DeleteAtIndex(index int) {
    if index < 0 || index >= this.size {
        return
    }
    prev := this.head
    for i := 0; i < index; i++ {
        prev = prev.Next
    }
    prev.Next = prev.Next.Next
    this.size--
}