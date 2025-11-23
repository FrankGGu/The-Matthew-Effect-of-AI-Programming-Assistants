package main


func swapNodes(head *ListNode, k int) *ListNode {
    // Find the k-th node from the beginning
    first := head
    for i := 1; i < k; i++ {
        first = first.Next
    }

    // Find the k-th node from the end
    second := head
    length := 0
    current := head
    for current != nil {
        length++
        current = current.Next
    }

    // Adjust k to be 1-based from the end
    kFromEnd := length - k + 1

    // Find the k-th node from the end
    second = head
    for i := 1; i < kFromEnd; i++ {
        second = second.Next
    }

    // Swap the values of the two nodes
    first.Val, second.Val = second.Val, first.Val

    return head
}