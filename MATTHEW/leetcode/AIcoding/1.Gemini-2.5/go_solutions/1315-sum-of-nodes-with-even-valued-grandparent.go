func sumEvenGrandparent(root *TreeNode) int {
	totalSum := 0

	var dfs func(node *TreeNode, parentVal int, grandParentVal int)
	dfs = func(node *TreeNode, parentVal