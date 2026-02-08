type ListNode struct {
    Val  int
    Next *ListNode
}

func rotateRight(head *ListNode, k int) *ListNode {
    if head == nil || head.Next == nil || k == 0 {
        return head
    }

    // Calculate the length of the list
    length := 1
    tail := head
    for tail.Next != nil {
        tail = tail.Next
        length++
    }

    // Connect the tail to the head to make it a circle
    tail.Next = head

    // Find the new tail position
    k = k % length
    newTailPos := length - k
    newTail := head
    for i := 1; i < newTailPos; i++ {
        newTail = newTail.Next
    }

    // Set the new head and break the circle
    newHead := newTail.Next
    newTail.Next = nil

    return newHead
}