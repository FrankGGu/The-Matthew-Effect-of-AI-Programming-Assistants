func insertIntoMaxTree(root *TreeNode, val int) *TreeNode {
	newNode := &TreeNode{Val: val}

	var parent *TreeNode
	curr :=