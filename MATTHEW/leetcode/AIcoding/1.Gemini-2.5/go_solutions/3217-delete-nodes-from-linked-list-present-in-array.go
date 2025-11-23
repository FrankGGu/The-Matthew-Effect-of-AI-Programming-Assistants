func deleteNodes(head *ListNode, nums []int) *ListNode {
    seen := make(map[int]bool)
    for _, num := range nums {
        seen[num] = true
    }

    dummy := &ListNode{Next: head}
    current := dummy

    for current.Next != nil {
        if seen[current.Next.Val] {
            current.Next = current.Next.Next
        } else {
            current = current.Next
        }
    }

    return dummy.Next
}