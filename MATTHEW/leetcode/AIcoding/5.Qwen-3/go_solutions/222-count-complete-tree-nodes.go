package main


func countCompleteTreeNodes(root *TreeNode) int {
	if root == nil {
		return 0
	}
	leftDepth := 0
	node := root
	for node != nil {
		node = node.Left
		leftDepth++
	}
	rightDepth := 0
	node = root
	for node != nil {
		node = node.Right
		rightDepth++
	}
	if leftDepth == rightDepth {
		return (1 << leftDepth) - 1
	}
	return 1 + countCompleteTreeNodes(root.Left) + countCompleteTreeNodes(root.Right)
}