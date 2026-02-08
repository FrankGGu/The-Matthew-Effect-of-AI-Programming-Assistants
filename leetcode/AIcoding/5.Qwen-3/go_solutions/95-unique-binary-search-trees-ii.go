package main


func generateTrees(n int) []*TreeNode {
	if n == 0 {
		return nil
	}
	return generate(1, n)
}

func generate(start, end int) []*TreeNode {
	if start > end {
		return []*TreeNode{nil}
	}
	result := []*TreeNode{}
	for i := start; i <= end; i++ {
		leftTrees := generate(start, i-1)
		rightTrees := generate(i+1, end)
		for _, left := range leftTrees {
			for _, right := range rightTrees {
				root := &TreeNode{Val: i, Left: left, Right: right}
				result = append(result, root)
			}
		}
	}
	return result
}