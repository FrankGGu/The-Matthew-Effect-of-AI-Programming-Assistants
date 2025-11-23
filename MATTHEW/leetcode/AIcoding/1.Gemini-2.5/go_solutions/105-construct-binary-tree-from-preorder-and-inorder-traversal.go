func buildTree(preorder []int, inorder []int) *TreeNode {
	inorderValToIndex := make(map[int]int)
	for i, val := range inorder {
		inorderValToIndex[val] = i
	}

	var build func(preStart, preEnd, inStart, inEnd int) *TreeNode
	build = func(preStart, preEnd, inStart, inEnd int) *TreeNode {
		if preStart > preEnd || inStart > inEnd {
			return nil
		}

		rootVal := preorder[preStart]
		root := &TreeNode{Val: rootVal}

		rootIndexInInorder := inorderValToIndex[rootVal]
		leftSubtreeSize := rootIndexInInorder - inStart

		root.Left = build(preStart+1, preStart+leftSubtreeSize, inStart, rootIndexInInorder-1)
		root.Right = build(preStart+leftSubtreeSize+1, preEnd, rootIndexInInorder+1, inEnd)

		return root
	}

	return build(0, len(preorder)-1, 0, len(inorder)-1)
}