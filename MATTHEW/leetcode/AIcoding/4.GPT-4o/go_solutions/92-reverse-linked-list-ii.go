type ListNode struct {
    Val  int
    Next *ListNode
}

func reverseBetween(head *ListNode, left int, right int) *ListNode {
    if head == nil || left == right {
        return head
    }

    dummy := &ListNode{Next: head}
    pre := dummy

    for i := 1; i < left; i++ {
        pre = pre.Next
    }

    curr := pre.Next
    var prev *ListNode
    for i := 0; i < right-left+1; i++ {
        next := curr.Next
        curr.Next = prev
        prev = curr
        curr = next
    }

    pre.Next.Next = curr
    pre.Next = prev

    return dummy.Next
}