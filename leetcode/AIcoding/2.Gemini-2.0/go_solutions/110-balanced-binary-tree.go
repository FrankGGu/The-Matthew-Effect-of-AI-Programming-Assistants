import "math"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func isBalanced(root *TreeNode) bool {
	_, balanced := isBalancedHelper(root)
	return balanced
}

func isBalancedHelper(root *TreeNode) (int, bool) {
	if root == nil {
		return 0, true
	}

	leftHeight, leftBalanced := isBalancedHelper(root.Left)
	if !leftBalanced {
		return 0, false
	}

	rightHeight, rightBalanced := isBalancedHelper(root.Right)
	if !rightBalanced {
		return 0, false
	}

	if math.Abs(float64(leftHeight-rightHeight)) > 1 {
		return 0, false
	}

	return int(math.Max(float64(leftHeight), float64(rightHeight))) + 1, true
}