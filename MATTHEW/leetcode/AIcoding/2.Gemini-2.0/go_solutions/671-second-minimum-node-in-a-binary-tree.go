import (
	"math"
)

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func findSecondMinimumValue(root *TreeNode) int {
	if root == nil {
		return -1
	}

	min1 := root.Val
	secondMin := math.MaxInt64

	var dfs func(node *TreeNode)
	dfs = func(node *TreeNode) {
		if node == nil {
			return
		}

		if node.Val > min1 && node.Val < secondMin {
			secondMin = node.Val
		} else if node.Val == min1 {
			dfs(node.Left)
			dfs(node.Right)
		} else if node.Val < min1 {
			min1 = node.Val
		}
	}

	dfs(root)

	if secondMin == math.MaxInt64 {
		return -1
	}

	return secondMin
}