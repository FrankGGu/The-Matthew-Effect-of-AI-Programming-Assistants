var cameras int

func dfs(node *TreeNode) int {
	if node == nil {
		return 1 // A nil node is considered covered and doesn't need a camera.
	}

	leftState := dfs(node.Left)
	rightState := dfs(node.Right)

	if leftState == 0 || rightState == 0 {
		// If any child is not covered (state 0), the current node MUST place a camera
		// to cover that child.
		cameras++
		return 2 // Current node has a camera.
	}

	if leftState == 2 || rightState == 2 {
		// If any child has a camera (state 2), it covers the current node.
		// The current node is covered and doesn't need a camera.
		return 1 // Current node is covered, no camera.
	}

	// If both children are covered (state 1) and neither has a camera,
	// the current node is not covered by its children, and it doesn't have a camera.
	// It needs its parent to cover it.
	return 0 // Current node needs to be covered by its parent.
}

func minCameraCover(root *TreeNode) int {
	cameras = 0 // Reset global counter for each test case

	// After the DFS traversal, if the root itself needs to be covered (state 0),
	// it means no parent covers it, so we must place a camera at the root.
	if dfs(root) == 0 {
		cameras++
	}

	return cameras
}