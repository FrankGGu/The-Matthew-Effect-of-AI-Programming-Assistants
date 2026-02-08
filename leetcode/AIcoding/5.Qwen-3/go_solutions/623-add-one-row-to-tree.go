package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func addOneRow(root *TreeNode, val int, depth int) *TreeNode {
	if depth == 1 {
		newNode := &TreeNode{Val: val}
		newNode.Left = root
		return newNode
	}

	queue := []*TreeNode{root}
	currentDepth := 1

	for len(queue) > 0 && currentDepth < depth-1 {
		nextLevel := []*TreeNode{}
		for _, node := range queue {
			if node.Left != nil {
				nextLevel = append(nextLevel, node.Left)
			}
			if node.Right != nil {
				nextLevel = append(nextLevel, node.Right)
			}
		}
		queue = nextLevel
		currentDepth++
	}

	for _, node := range queue {
		newLeft := &TreeNode{Val: val}
		newLeft.Left = node.Left
		node.Left = newLeft

		newRight := &TreeNode{Val: val}
		newRight.Right = node.Right
		node.Right = newRight
	}

	return root
}