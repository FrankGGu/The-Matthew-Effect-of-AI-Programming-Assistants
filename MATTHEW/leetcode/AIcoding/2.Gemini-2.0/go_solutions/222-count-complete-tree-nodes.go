type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func countNodes(root *TreeNode) int {
	if root == nil {
		return 0
	}

	leftHeight := 0
	rightHeight := 0
	leftNode := root
	rightNode := root

	for leftNode != nil {
		leftHeight++
		leftNode = leftNode.Left
	}

	for rightNode != nil {
		rightHeight++
		rightNode = rightNode.Right
	}

	if leftHeight == rightHeight {
		return (1 << leftHeight) - 1
	}

	return 1 + countNodes(root.Left) + countNodes(root.Right)
}