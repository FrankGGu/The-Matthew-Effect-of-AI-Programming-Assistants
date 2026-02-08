import "math"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func maximumSum(root *TreeNode) int {
	type Result struct {
		WithRoot    int
		WithoutRoot int
	}

	var dfs func(*TreeNode) Result
	dfs = func(node *TreeNode) Result {
		if node == nil {
			return Result{WithRoot: 0, WithoutRoot: 0}
		}

		left := dfs(node.Left)
		right := dfs(node.Right)

		withRoot := node.Val + left.WithoutRoot + right.WithoutRoot
		withoutRoot := int(math.Max(float64(left.WithRoot), float64(left.WithoutRoot))) + int(math.Max(float64(right.WithRoot), float64(right.WithoutRoot)))

		return Result{WithRoot: withRoot, WithoutRoot: withoutRoot}
	}

	result := dfs(root)
	return int(math.Max(float64(result.WithRoot), float64(result.WithoutRoot)))
}