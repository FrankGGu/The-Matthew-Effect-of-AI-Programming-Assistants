type MyLinkedList struct {
    head *ListNode
    size int
}

type ListNode struct {
    Val int
    Next *ListNode
}

func Constructor() MyLinkedList {
    return MyLinkedList{head: nil, size: 0}
}

func (this *MyLinkedList) Get(index int) int {
    if index < 0 || index >= this.size {
        return -1
    }
    curr := this.head
    for i := 0; i < index; i++ {
        curr = curr.Next
    }
    return curr.Val
}

func (this *MyLinkedList) AddAtHead(val int)  {
    newNode := &ListNode{Val: val, Next: this.head}
    this.head = newNode
    this.size++
}

func (this *MyLinkedList) AddAtTail(val int) {
    newNode := &ListNode{Val: val, Next: nil}
    if this.head == nil {
        this.head = newNode
    } else {
        curr := this.head
        for curr.Next != nil {
            curr = curr.Next
        }
        curr.Next = newNode
    }
    this.size++
}

func (this *MyLinkedList) AddAtIndex(index int, val int)  {
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
    newNode := &ListNode{Val: val, Next: nil}
    curr := this.head
    for i := 0; i < index-1; i++ {
        curr = curr.Next
    }
    newNode.Next = curr.Next
    curr.Next = newNode
    this.size++
}

func (this *MyLinkedList) DeleteAtIndex(index int)  {
    if index < 0 || index >= this.size {
        return
    }
    if index == 0 {
        this.head = this.head.Next
    } else {
        curr := this.head
        for i := 0; i < index-1; i++ {
            curr = curr.Next
        }
        curr.Next = curr.Next.Next
    }
    this.size--
}