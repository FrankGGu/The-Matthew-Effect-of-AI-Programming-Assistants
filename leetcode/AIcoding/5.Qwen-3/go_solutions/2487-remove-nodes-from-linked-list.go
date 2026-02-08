package main


func removeNodes(head *ListNode) *ListNode {
    var stack []*ListNode
    current := head
    for current != nil {
        for len(stack) > 0 && stack[len(stack)-1].Val < current.Val {
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, current)
        current = current.Next
    }
    dummy := &ListNode{}
    current = dummy
    for _, node := range stack {
        current.Next = node
        current = current.Next
    }
    return dummy.Next
}