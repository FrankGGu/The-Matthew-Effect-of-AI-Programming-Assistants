type Node struct {
    value int
    next  *Node
}

type MyLinkedList struct {
    head *Node
    tail *Node
    size int
}

func Constructor() MyLinkedList {
    return MyLinkedList{}
}

func (this *MyLinkedList) Get(index int) int {
    if index < 0 || index >= this.size {
        return -1
    }
    current := this.head
    for i := 0; i < index; i++ {
        current = current.next
    }
    return current.value
}

func (this *MyLinkedList) AddAtHead(val int) {
    newNode := &Node{value: val}
    if this.size == 0 {
        this.head = newNode
        this.tail = newNode
    } else {
        newNode.next = this.head
        this.head = newNode
    }
    this.size++
}

func (this *MyLinkedList) AddAtTail(val int) {
    newNode := &Node{value: val}
    if this.size == 0 {
        this.head = newNode
        this.tail = newNode
    } else {
        this.tail.next = newNode
        this.tail = newNode
    }
    this.size++
}

func (this *MyLinkedList) AddAtIndex(index int, val int) {
    if index < 0 || index > this.size {
        return
    }
    if index == 0 {
        this.AddAtHead(val)
        return
    }
    if index == this.size {
        this.AddAtTail(val)
        return
    }
    newNode := &Node{value: val}
    current := this.head
    for i := 0; i < index-1; i++ {
        current = current.next
    }
    newNode.next = current.next
    current.next = newNode
    this.size++
}

func (this *MyLinkedList) DeleteAtIndex(index int) {
    if index < 0 || index >= this.size {
        return
    }
    if index == 0 {
        this.head = this.head.next
        if this.size == 1 {
            this.tail = nil
        }
    } else {
        current := this.head
        for i := 0; i < index-1; i++ {
            current = current.next
        }
        current.next = current.next.next
        if index == this.size-1 {
            this.tail = current
        }
    }
    this.size--
}