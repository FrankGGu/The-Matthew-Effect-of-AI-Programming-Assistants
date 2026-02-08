type ListNode struct {
    Val  int
    Next *ListNode
}

func mergeNodes(head *ListNode) *ListNode {
    dummy := &ListNode{0, nil}
    current := dummy
    sum := 0
    head = head.Next

    for head != nil {
        if head.Val == 0 {
            if sum > 0 {
                current.Next = &ListNode{sum, nil}
                current = current.Next
                sum = 0
            }
        } else {
            sum += head.Val
        }
        head = head.Next
    }

    return dummy.Next
}