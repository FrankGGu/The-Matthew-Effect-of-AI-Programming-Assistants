type ListNode struct {
    Val  int
    Next *ListNode
}

func mergeInBetween(list1 *ListNode, a int, b int, list2 *ListNode) *ListNode {
    dummy := &ListNode{Next: list1}
    prev := dummy
    for i := 0; i < a; i++ {
        prev = prev.Next
    }

    curr := prev.Next
    for i := 0; i <= b-a; i++ {
        curr = curr.Next
    }

    prev.Next = list2
    for list2.Next != nil {
        list2 = list2.Next
    }
    list2.Next = curr

    return dummy.Next
}