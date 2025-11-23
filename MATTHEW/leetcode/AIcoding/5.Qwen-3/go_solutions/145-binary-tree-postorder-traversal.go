package main


func postorderTraversal(root *TreeNode) []int {
    var result []int
    var stack []*TreeNode
    var lastVisited *TreeNode
    current := root
    for current != nil || len(stack) > 0 {
        for current != nil {
            stack = append(stack, current)
            current = current.Left
        }
        current = stack[len(stack)-1]
        stack = stack[:len(stack)-1]
        if current.Right == nil || current.Right == lastVisited {
            result = append(result, current.Val)
            lastVisited = current
            current = nil
        } else {
            stack = append(stack, current)
            current = current.Right
        }
    }
    return result
}