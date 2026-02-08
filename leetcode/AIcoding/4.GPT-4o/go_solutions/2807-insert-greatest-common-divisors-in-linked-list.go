type ListNode struct {
    Val  int
    Next *ListNode
}

func insertGCDs(head *ListNode) *ListNode {
    if head == nil {
        return nil
    }

    dummy := &ListNode{Next: head}
    prev := dummy
    curr := head

    for curr != nil && curr.Next != nil {
        gcdVal := gcd(curr.Val, curr.Next.Val)
        newNode := &ListNode{Val: gcdVal}
        newNode.Next = curr.Next
        curr.Next = newNode
        prev = newNode
        curr = newNode.Next
    }

    return dummy.Next
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}