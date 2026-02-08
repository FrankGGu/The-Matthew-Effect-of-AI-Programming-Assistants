package main


func reverseOddLevels(root *TreeNode) *TreeNode {
	if root == nil {
		return nil
	}

	queue := []*TreeNode{root}
	level := 0

	for len(queue) > 0 {
		size := len(queue)
		levelNodes := make([]*TreeNode, size)

		for i := 0; i < size; i++ {
			node := queue[0]
			queue = queue[1:]
			levelNodes[i] = node

			if node.Left != nil {
				queue = append(queue, node.Left)
			}
			if node.Right != nil {
				queue = append(queue, node.Right)
			}
		}

		if level%2 == 1 {
			for i, j := 0, len(levelNodes)-1; i < j; i, j = i+1, j-1 {
				levelNodes[i].Val, levelNodes[j].Val = levelNodes[j].Val, levelNodes[i].Val
			}
		}

		level++
	}

	return root
}