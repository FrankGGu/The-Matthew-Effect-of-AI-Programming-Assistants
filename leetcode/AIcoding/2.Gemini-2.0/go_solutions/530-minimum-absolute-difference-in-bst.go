import (
	"math"
)

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func getMinimumDifference(root *TreeNode) int {
	var prev *TreeNode
	minDiff := math.MaxInt32
	var inorder func(*TreeNode)
	inorder = func(node *TreeNode) {
		if node == nil {
			return
		}
		inorder(node.Left)
		if prev != nil {
			diff := node.Val - prev.Val
			if diff < minDiff {
				minDiff = diff
			}
		}
		prev = node
		inorder(node.Right)
	}
	inorder(root)
	return minDiff
}