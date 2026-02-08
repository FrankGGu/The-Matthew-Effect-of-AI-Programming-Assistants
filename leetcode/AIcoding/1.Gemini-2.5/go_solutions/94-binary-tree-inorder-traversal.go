func inorderTraversal(root *TreeNode) []int {
    result := []int{}

    var traverse func(node *TreeNode)
    traverse = func(node *TreeNode) {
        if node == nil {
            return
        }
        traverse(node.Left)
        result = append(result, node.Val)
        traverse(node.Right)
    }

    traverse(root)
    return result
}