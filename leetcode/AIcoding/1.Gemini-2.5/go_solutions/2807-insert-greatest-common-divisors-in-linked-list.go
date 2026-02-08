func insertGreatestCommonDivisors(head *ListNode) *ListNode {
    if head == nil || head.Next == nil {
        return head
    }

    current := head
    for current != nil && current.Next != nil {
        val1 := current.Val
        val2 := current.Next.Val

        commonDivisor := gcd(val1, val2)

        newNode := &ListNode{Val: commonDivisor}

        newNode.Next = current.Next
        current.Next = newNode

        current = current.Next.Next
    }

    return head
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a % b
    }
    return a
}