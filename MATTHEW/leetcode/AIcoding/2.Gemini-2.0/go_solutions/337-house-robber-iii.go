type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func rob(root *TreeNode) int {
	result := robHelper(root)
	return max(result[0], result[1])
}

func robHelper(node *TreeNode) []int {
	if node == nil {
		return []int{0, 0}
	}

	left := robHelper(node.Left)
	right := robHelper(node.Right)

	robWithNode := node.Val + left[1] + right[1]
	robWithoutNode := max(left[0], left[1]) + max(right[0], right[1])

	return []int{robWithNode, robWithoutNode}
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}