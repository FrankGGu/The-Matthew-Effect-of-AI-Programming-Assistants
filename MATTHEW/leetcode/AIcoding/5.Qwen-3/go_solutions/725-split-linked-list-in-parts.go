package main


func splitListToParts(root *ListNode, k int) []*ListNode {
    var length int
    node := root
    for node != nil {
        length++
        node = node.Next
    }

    result := make([]*ListNode, k)
    current := root
    for i := 0; i < k; i++ {
        result[i] = current
        size := (length + k - 1 - i) / k
        for j := 0; j < size-1 && current != nil; j++ {
            current = current.Next
        }
        if current != nil {
            next := current.Next
            current.Next = nil
            current = next
        }
    }
    return result
}