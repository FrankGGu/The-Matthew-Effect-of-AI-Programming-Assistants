func numComponents(head *ListNode, nums []int) int {
    numSet := make(map[int]bool)
    for _, num := range nums {
        numSet[num] = true
    }

    components := 0
    inComponent := false

    current := head
    for current != nil {
        if numSet[current.Val] {
            if !inComponent {
                components++
                inComponent = true
            }
        } else {
            inComponent = false
        }
        current = current.Next
    }

    return components
}