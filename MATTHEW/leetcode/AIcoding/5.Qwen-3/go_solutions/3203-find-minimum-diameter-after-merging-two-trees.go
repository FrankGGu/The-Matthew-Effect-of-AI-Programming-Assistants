package main


func minTreeDiameterMerge(root1 *TreeNode, root2 *TreeNode) int {
	var maxDepth func(node *TreeNode) int
	maxDepth = func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		return 1 + max(maxDepth(node.Left), maxDepth(node.Right))
	}

	var getDiameters func(node *TreeNode) int
	getDiameters = func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		left := maxDepth(node.Left)
		right := maxDepth(node.Right)
		diameter := left + right
		return max(diameter, getDiameters(node.Left), getDiameters(node.Right))
	}

	d1 := getDiameters(root1)
	d2 := getDiameters(root2)

	depth1 := maxDepth(root1)
	depth2 := maxDepth(root2)

	return max(d1, d2, depth1+depth2)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}