type ListNode struct {
    Val  int
    Next *ListNode
}

func removeNodes(head *ListNode) *ListNode {
    var stack []*ListNode
    for curr := head; curr != nil; curr = curr.Next {
        for len(stack) > 0 && stack[len(stack)-1].Val < curr.Val {
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, curr)
    }
    for i := 0; i < len(stack)-1; i++ {
        stack[i].Next = stack[i+1]
    }
    if len(stack) > 0 {
        stack[len(stack)-1].Next = nil
        return stack[0]
    }
    return nil
}