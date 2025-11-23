func rotateRight(head *ListNode, k int) *ListNode {
    if head == nil || head.Next == nil || k == 0 {
        return head
    }

    // Calculate the length of the list and find the tail
    length := 1
    tail := head
    for tail.Next != nil {
        tail = tail.Next
        length++
    }

    // Calculate effective rotations
    k = k % length
    if k == 0 {
        return head
    }

    // Find the new tail (which is (length - k - 1)th node from head)
    // and the new head (which is (length - k)th node from head)
    // The new tail will be the node right before the new head
    newTailPosition := length - k - 1
    current := head
    for i := 0; i < newTailPosition; i++ {
        current = current.Next
    }

    newHead := current.Next
    current.Next = nil // Break the list at the new tail

    tail.Next = head // Connect the original tail to the original head

    return newHead
}