type ListNode struct {
    Val  int
    Next *ListNode
}

func splitListToParts(head *ListNode, k int) []*ListNode {
    var result []*ListNode
    current := head
    length := 0

    for current != nil {
        length++
        current = current.Next
    }

    partSize := length / k
    extraParts := length % k

    current = head
    for i := 0; i < k; i++ {
        result = append(result, current)
        size := partSize
        if i < extraParts {
            size++
        }

        for j := 0; j < size && current != nil; j++ {
            if j == size-1 {
                next := current.Next
                current.Next = nil
                current = next
            } else {
                current = current.Next
            }
        }
    }

    return result
}