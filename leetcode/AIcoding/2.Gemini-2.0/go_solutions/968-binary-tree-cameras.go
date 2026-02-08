import "math"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func minCameraCover(root *TreeNode) int {
	res := 0
	if dfs(root, &res) == 0 {
		res++
	}
	return res
}

func dfs(root *TreeNode, res *int) int {
	if root == nil {
		return 1
	}

	l := dfs(root.Left, res)
	r := dfs(root.Right, res)

	if l == 0 || r == 0 {
		*res++
		return 2
	}

	if l == 2 || r == 2 {
		return 1
	}

	return 0
}