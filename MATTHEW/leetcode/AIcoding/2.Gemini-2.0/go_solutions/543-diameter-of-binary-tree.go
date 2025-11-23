import "math"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func diameterOfBinaryTree(root *TreeNode) int {
	maxDiameter := 0

	var depth func(*TreeNode) int
	depth = func(node *TreeNode) int {
		if node == nil {
			return 0
		}

		leftDepth := depth(node.Left)
		rightDepth := depth(node.Right)

		maxDiameter = int(math.Max(float64(maxDiameter), float64(leftDepth+rightDepth)))

		return int(math.Max(float64(leftDepth), float64(rightDepth))) + 1
	}

	depth(root)
	return maxDiameter
}