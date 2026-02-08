func createBinaryTree(descriptions [][]int) *TreeNode {
	nodes := make(map[int]*TreeNode)
	isChild := make(map[int]bool)

	for _, desc := range descriptions {
		parentVal := desc[0]
		childVal := desc[1]
		isLeft := desc[2] == 1

		if _, ok := nodes[parentVal]; !ok {
			nodes[parentVal] = &TreeNode{Val: parentVal}
		}
		if _, ok := nodes[childVal]; !ok {
			nodes[childVal] = &TreeNode{Val: childVal}
		}

		if isLeft {
			nodes[parentVal].Left = nodes[childVal]
		} else {
			nodes[parentVal].Right = nodes[childVal]
		}

		isChild[childVal] = true
	}

	var root *TreeNode
	for val, node := range nodes {
		if !isChild[val] {
			root = node
			break
		}
	}

	return root
}