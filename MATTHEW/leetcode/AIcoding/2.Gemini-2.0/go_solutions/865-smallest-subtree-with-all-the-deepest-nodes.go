type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func subtreeWithAllDeepest(root *TreeNode) *TreeNode {
	depth := func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		return max(depth(node.Left), depth(node.Right)) + 1
	}

	maxDepth := depth(root)

	var ans *TreeNode

	var find func(node *TreeNode, d int) bool
	find = func(node *TreeNode, d int) bool {
		if node == nil {
			return false
		}
		if d == maxDepth {
			return true
		}

		left := find(node.Left, d+1)
		right := find(node.Right, d+1)

		if left && right {
			ans = node
			return true
		}
		return left || right
	}

	find(root, 1)
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}