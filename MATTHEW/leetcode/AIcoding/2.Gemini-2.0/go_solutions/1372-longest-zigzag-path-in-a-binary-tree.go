import "math"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func longestZigZag(root *TreeNode) int {
	var maxLen int

	var dfs func(node *TreeNode, direction int, length int)
	dfs = func(node *TreeNode, direction int, length int) {
		if node == nil {
			return
		}

		maxLen = int(math.Max(float64(maxLen), float64(length)))

		if direction == 0 { // Going left
			dfs(node.Left, 0, 1)
			dfs(node.Right, 1, length+1)
		} else { // Going right
			dfs(node.Right, 1, 1)
			dfs(node.Left, 0, length+1)
		}
	}

	dfs(root, 0, 0) // Start from root, going left
	dfs(root, 1, 0) // Start from root, going right

	return maxLen
}