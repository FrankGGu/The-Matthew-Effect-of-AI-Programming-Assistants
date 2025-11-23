func removeLeafNodes(root *TreeNode, target int) *TreeNode {
	if root == nil {
		return nil
	}

	// Recursively process left and right children first (post-order traversal)
	root.Left = removeLeafNodes(root.Left, target)
	root.Right = removeLeafNodes(root.Right, target)

	// After children have been processed, check if the current node
	// has become a leaf (or was originally a leaf) and its value matches the target.
	if root.Left == nil && root.Right == nil && root.Val == target {
		// If it's a leaf node with the target value, delete it by returning nil to its parent.
		return nil
	}

	// Otherwise, keep this node and return it to its parent.
	return root
}