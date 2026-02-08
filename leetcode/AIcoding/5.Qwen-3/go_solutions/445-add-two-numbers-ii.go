package main


func addTwoNumbers(l1 *ListNode, l2 *ListNode) *ListNode {
    var stack1, stack2 []*ListNode
    for l1 != nil {
        stack1 = append(stack1, l1)
        l1 = l1.Next
    }
    for l2 != nil {
        stack2 = append(stack2, l2)
        l2 = l2.Next
    }

    var carry int
    var result *ListNode = nil

    for len(stack1) > 0 || len(stack2) > 0 || carry > 0 {
        var val1, val2 int
        if len(stack1) > 0 {
            val1 = stack1[len(stack1)-1].Val
            stack1 = stack1[:len(stack1)-1]
        }
        if len(stack2) > 0 {
            val2 = stack2[len(stack2)-1].Val
            stack2 = stack2[:len(stack2)-1]
        }
        sum := val1 + val2 + carry
        carry = sum / 10
        node := &ListNode{Val: sum % 10}
        node.Next = result
        result = node
    }

    return result
}