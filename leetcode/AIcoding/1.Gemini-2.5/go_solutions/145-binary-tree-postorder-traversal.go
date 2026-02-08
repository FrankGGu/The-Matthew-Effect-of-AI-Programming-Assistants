func postorderTraversal(root *TreeNode) []int {
	var result []int
	var traverse func(*TreeNode)

	traverse = func(node *TreeNode) {
		if node == nil {
			return
		}
		traverse(node.Left)
		traverse(node.Right)
		result = append(result, node.Val)
	}

	traverse(root)
	return result
}