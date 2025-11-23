package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func isCompleteTree(root *TreeNode) bool {
	if root == nil {
		return true
	}

	queue := []*TreeNode{root}
	hasNull := false

	for len(queue) > 0 {
		node := queue[0]
		queue = queue[1:]

		if node == nil {
			hasNull = true
			continue
		}

		if hasNull {
			return false
		}

		queue = append(queue, node.Left)
		queue = append(queue, node.Right)
	}

	return true
}