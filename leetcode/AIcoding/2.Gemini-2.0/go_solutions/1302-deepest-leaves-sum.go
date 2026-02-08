type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func deepestLeavesSum(root *TreeNode) int {
	maxDepth := 0
	sum := 0

	var dfs func(*TreeNode, int)
	dfs = func(node *TreeNode, depth int) {
		if node == nil {
			return
		}

		if node.Left == nil && node.Right == nil {
			if depth > maxDepth {
				maxDepth = depth
				sum = node.Val
			} else if depth == maxDepth {
				sum += node.Val
			}
			return
		}

		dfs(node.Left, depth+1)
		dfs(node.Right, depth+1)
	}

	dfs(root, 0)
	return sum
}