type ListNode struct {
    Val  int
    Next *ListNode
}

func doubleIt(head *ListNode) *ListNode {
    dummy := &ListNode{0, nil}
    current := dummy
    carry := 0

    for p := head; p != nil; p = p.Next {
        val := p.Val*2 + carry
        carry = val / 10
        current.Next = &ListNode{Val: val % 10}
        current = current.Next
    }

    if carry > 0 {
        current.Next = &ListNode{Val: carry}
    }

    return reverse(dummy.Next)
}

func reverse(head *ListNode) *ListNode {
    var prev *ListNode
    curr := head
    for curr != nil {
        next := curr.Next
        curr.Next = prev
        prev = curr
        curr = next
    }
    return prev
}