type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func lcaDeepestLeaves(root *TreeNode) *TreeNode {
	var deepestLevel int
	var lca *TreeNode

	var dfs func(*TreeNode, int) int
	dfs = func(node *TreeNode, level int) int {
		if node == nil {
			return level - 1
		}

		leftDepth := dfs(node.Left, level+1)
		rightDepth := dfs(node.Right, level+1)

		if leftDepth == rightDepth {
			if leftDepth >= deepestLevel {
				deepestLevel = leftDepth
				lca = node
			}
		} else if leftDepth > rightDepth {
			return leftDepth
		} else {
			return rightDepth
		}

		return max(leftDepth, rightDepth)
	}

	dfs(root, 0)
	return lca
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}