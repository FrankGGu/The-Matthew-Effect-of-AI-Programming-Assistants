type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func flipMatchVoyage(root *TreeNode, voyage []int) []int {
	res := []int{}
	idx := 0

	var dfs func(node *TreeNode) bool
	dfs = func(node *TreeNode) bool {
		if node == nil {
			return true
		}

		if node.Val != voyage[idx] {
			return false
		}

		idx++

		if node.Left != nil && node.Left.Val != voyage[idx] && node.Right != nil && node.Right.Val == voyage[idx] {
			res = append(res, node.Val)
			node.Left, node.Right = node.Right, node.Left
		}

		return dfs(node.Left) && dfs(node.Right)
	}

	if dfs(root) {
		if len(res) == 0 {
			return []int{}
		}
		return res
	}

	return []int{-1}
}