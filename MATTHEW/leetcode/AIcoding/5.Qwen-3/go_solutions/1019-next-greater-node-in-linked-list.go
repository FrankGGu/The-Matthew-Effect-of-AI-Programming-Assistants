package main


func nextLargerNodes(head *ListNode) []int {
    var stack []*ListNode
    var result []int
    current := head
    index := 0
    for current != nil {
        result = append(result, 0)
        for len(stack) > 0 && stack[len(stack)-1].Val < current.Val {
            top := stack[len(stack)-1]
            result[top.Val] = current.Val
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, current)
        current = current.Next
        index++
    }
    return result
}