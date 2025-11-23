type ListNode struct {
    Val  int
    Next *ListNode
}

func nextLargerNodes(head *ListNode) []int {
    var stack []int
    var result []int
    var values []int

    for node := head; node != nil; node = node.Next {
        values = append(values, node.Val)
        result = append(result, 0)
    }

    for i := 0; i < len(values); i++ {
        for len(stack) > 0 && values[stack[len(stack)-1]] < values[i] {
            result[stack[len(stack)-1]] = values[i]
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, i)
    }

    return result
}