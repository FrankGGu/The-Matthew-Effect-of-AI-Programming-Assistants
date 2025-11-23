func postorderTraversal(root *TreeNode) []int {
    res := []int{}
    var traverse func(node *TreeNode)
    traverse = func(node *TreeNode) {
        if node == nil {
            return
        }
        traverse(node.Left)
        traverse(node.Right)
        res = append(res, node.Val)
    }
    traverse(root)
    return res
}