func averageOfLevels(root *TreeNode) []float64 {
	if root == nil {
		return []float64{}
	}

	var result []float64
	queue := []*TreeNode{root}

	for len(queue) > 0 {
		levelSize := len(queue)
		var levelSum float64
		var levelCount int

		for i := 0; i < levelSize; i++ {
			node := queue[0]
			queue = queue[1:]

			levelSum += float64(node.Val)
			levelCount++

			if node.Left != nil {
				queue = append(queue, node.Left)
			}
			if node.Right != nil {
				queue = append(queue, node.Right)
			}
		}
		result = append(result, levelSum/float64(levelCount))
	}
	return result
}