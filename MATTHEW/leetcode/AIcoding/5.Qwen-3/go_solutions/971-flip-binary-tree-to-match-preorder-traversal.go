package main


func flipMatchVoyage(root *TreeNode, voyage []int) []int {
	var result []int
	var index int

	var dfs func(node *TreeNode)
	dfs = func(node *TreeNode) {
		if node == nil {
			return
		}
		if node.Val != voyage[index] {
			result = []int{-1}
			return
		}
		index++
		if index < len(voyage) && node.Left != nil && node.Left.Val != voyage[index] {
			result = append(result, node.Val)
			dfs(node.Right)
			dfs(node.Left)
		} else {
			dfs(node.Left)
			dfs(node.Right)
		}
	}

	dfs(root)
	if len(result) > 0 && result[0] == -1 {
		return []int{-1}
	}
	return result
}