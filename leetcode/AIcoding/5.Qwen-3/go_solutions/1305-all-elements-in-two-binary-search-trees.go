package main


func getAllElements(root1 *TreeNode, root2 *TreeNode) []int {
	var res []int
	var dfs func(node *TreeNode)
	dfs = func(node *TreeNode) {
		if node == nil {
			return
		}
		dfs(node.Left)
		res = append(res, node.Val)
		dfs(node.Right)
	}
	dfs(root1)
	dfs(root2)
	sort.Ints(res)
	return res
}