import "math"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func isBalanced(root *TreeNode) bool {
	if root == nil {
		return true
	}
	height := func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		return 1 + int(math.Max(float64(height(node.Left)), float64(height(node.Right))))
	}

	if math.Abs(float64(height(root.Left)-height(root.Right))) > 1 {
		return false
	}

	return isBalanced(root.Left) && isBalanced(root.Right)
}