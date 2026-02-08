func mergeBSTs(trees []*TreeNode) *TreeNode {
	rootMap := make(map[int]*TreeNode)
	allNodeValues := make(map[int]int)

	for _, tree := range trees {
		rootMap[tree.Val] = tree

		var countNodesDFS func(node *TreeNode)
		countNodesDFS = func(node *TreeNode) {
			if node == nil {
				return
			}
			allNodeValues[node.Val]++
			countNodesDFS(node.Left)
			countNodesDFS(node.Right)
		}
		countNodesDFS(tree)
	}

	candidateRoot := (*TreeNode)(nil)
	numRootsWithFreqOne := 0
	for _, tree := range trees {
		if allNodeValues[tree.Val] == 1 {
			candidateRoot = tree
			numRootsWithFreqOne++
		}
	}

	if numRootsWithFreqOne != 1 {
		return nil
	}

	var dfs func(node *TreeNode, minVal, maxVal int) (*TreeNode, bool)
	dfs = func(node *TreeNode, minVal, maxVal int) (*TreeNode, bool) {
		if node == nil {
			return nil, true
		}

		if node.Val <= minVal || node.Val >= maxVal {
			return nil, false
		}

		allNodeValues[node.Val]--
		if allNodeValues[node.Val] < 0 {
			return nil, false
		}

		if node.Left == nil && node.Right == nil {
			if replacementTree, ok := rootMap[node.Val]; ok && replacementTree != node {
				mergedReplacement, ok := dfs(replacementTree, minVal, maxVal)
				if !ok {
					return nil, false
				}
				return mergedReplacement, true
			}
		}

		leftSubtree, ok := dfs(node.Left, minVal, node.Val)
		if !ok {
			return nil, false
		}
		node.Left = leftSubtree

		rightSubtree, ok := dfs(node.Right, node.Val, maxVal)
		if !ok {
			return nil, false
		}
		node.Right = rightSubtree

		return node, true
	}

	finalRoot, ok := dfs(candidateRoot, -1, 100001)
	if !ok {
		return nil
	}

	for _, count := range allNodeValues {
		if count != 0 {
			return nil
		}
	}

	return finalRoot
}