package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func isBalanced(root *TreeNode) bool {
	_, balanced := getHeightAndBalance(root)
	return balanced
}

func getHeightAndBalance(node *TreeNode) (int, bool) {
	if node == nil {
		return 0, true
	}

	leftHeight, leftBalanced := getHeightAndBalance(node.Left)
	rightHeight, rightBalanced := getHeightAndBalance(node.Right)

	if !leftBalanced || !rightBalanced {
		return 0, false
	}

	if abs(leftHeight-rightHeight) > 1 {
		return 0, false
	}

	return max(leftHeight, rightHeight) + 1, true
}

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}