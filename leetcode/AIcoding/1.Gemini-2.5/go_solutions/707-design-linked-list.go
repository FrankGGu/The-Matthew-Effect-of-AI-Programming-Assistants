type ListNode struct {
	Val  int
	Next *ListNode
}

type MyLinkedList struct {
	head *ListNode
	tail *ListNode
	size int
}

func Constructor() MyLinkedList {
	return MyLinkedList{head: nil, tail: nil, size: 0}
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

func (this *MyLinkedList) AddAtHead(val int) {
	newNode := &ListNode{Val: val, Next: this.head}
	this.head = newNode
	if this.tail == nil {
		this.tail = newNode
	}
	this.size++
}

func (this *MyLinkedList) AddAtTail(val int) {
	newNode := &ListNode{Val: val}
	if this.tail != nil {
		this.tail.Next = newNode
	} else {
		this.head = newNode
	}
	this.tail = newNode
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

	newNode := &ListNode{Val: val}
	curr := this.head
	for i := 0; i < index-1; i++ {
		curr = curr.Next
	}
	newNode.Next = curr.Next
	curr.Next = newNode
	this.size++
}

func (this *MyLinkedList) DeleteAtIndex(index int) {
	if index < 0 || index >= this.size {
		return
	}

	if index == 0 {
		this.head = this.head.Next
		if this.head == nil {
			this.tail = nil
		}
	} else {
		curr := this.head
		for i := 0; i < index-1; i++ {
			curr = curr.Next
		}
		curr.Next = curr.Next.Next
		if curr.Next == nil {
			this.tail = curr
		}
	}
	this.size--
}