func mergeTrees(root1 *TreeNode, root2 *TreeNode) *TreeNode {
	if root1 == nil && root2 == nil {
		return nil
	}
	if root1 == nil {
		return root2
	}
	if root2 == nil {
		return root1
	}

	newNode := &TreeNode{
		Val: root1.Val + root2.Val,
	}

	newNode.Left = mergeTrees(root1.Left, root2.Left)
	newNode.Right = mergeTrees(root1.Right, root2.Right)

	return newNode
}