func convertBST(root *TreeNode) *TreeNode {
    sum := 0

    var traverse func(*TreeNode)
    traverse = func(node *TreeNode) {
        if node == nil {
            return
        }

        traverse(node.Right)

        sum += node.Val
        node.Val = sum

        traverse(node.Left)
    }

    traverse(root)
    return root
}