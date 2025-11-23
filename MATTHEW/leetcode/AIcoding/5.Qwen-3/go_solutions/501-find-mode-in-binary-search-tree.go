package main


func findMode(root *TreeNode) []int {
    var result []int
    var prev *TreeNode
    var maxCount, currentCount int

    var inorder func(*TreeNode)
    inorder = func(node *TreeNode) {
        if node == nil {
            return
        }
        inorder(node.Left)
        if prev != nil && prev.Val == node.Val {
            currentCount++
        } else {
            currentCount = 1
        }
        if currentCount > maxCount {
            maxCount = currentCount
            result = []int{node.Val}
        } else if currentCount == maxCount {
            result = append(result, node.Val)
        }
        prev = node
        inorder(node.Right)
    }

    inorder(root)
    return result
}