var maxD int

func diameterOfBinaryTree(root *TreeNode) int {
	maxD = 0
	depth(root)
	return maxD
}

func depth(node *TreeNode) int {
	if node == nil {
		return 0
	}

	leftDepth := depth(node.Left)
	rightDepth := depth(node.Right)

	maxD = max(maxD, leftDepth+rightDepth)

	return 1 + max(leftDepth, rightDepth)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}