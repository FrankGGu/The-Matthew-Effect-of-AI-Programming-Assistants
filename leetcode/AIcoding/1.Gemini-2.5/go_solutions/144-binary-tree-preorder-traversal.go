func preorderTraversal(root *TreeNode) []int {
    var result []int

    var traverse func(*TreeNode)
    traverse = func(node *TreeNode) {
        if node == nil {
            return
        }
        result = append(result, node.Val)
        traverse(node.Left)
        traverse(node.Right)
    }

    traverse(root)
    return result
}