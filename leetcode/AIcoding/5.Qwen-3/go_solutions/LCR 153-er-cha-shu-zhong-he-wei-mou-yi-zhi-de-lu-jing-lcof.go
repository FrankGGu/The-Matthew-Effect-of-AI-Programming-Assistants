package main


func pathSum(root *TreeNode, target int) [][]int {
	var result [][]int
	var dfs func(*TreeNode, int, []int)
	dfs = func(node *TreeNode, remaining int, path []int) {
		if node == nil {
			return
		}
		remaining -= node.Val
		path = append(path, node.Val)
		if remaining == 0 && node.Left == nil && node.Right == nil {
			result = append(result, append([]int{}, path...))
		}
		dfs(node.Left, remaining, path)
		dfs(node.Right, remaining, path)
		path = path[:len(path)-1]
	}
	dfs(root, target, []int{})
	return result
}