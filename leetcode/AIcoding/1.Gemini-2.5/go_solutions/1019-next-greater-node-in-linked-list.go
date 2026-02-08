func nextLargerNodes(head *ListNode) []int {
    var values []int
    current := head
    for current != nil {
        values = append(values, current.Val)
        current = current.Next
    }

    n := len(values)
    result := make([]int, n)

    var stack []int // Stores indices

    for i := 0; i < n; i++ {
        for len(stack) > 0 && values[stack[len(stack)-1]] < values[i] {
            prevIndex := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            result[prevIndex] = values[i]
        }
        stack = append(stack, i)
    }

    return result
}