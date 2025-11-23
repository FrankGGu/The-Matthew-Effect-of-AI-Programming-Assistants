package main


func binaryTreePaths(root *TreeNode) []string {
	var result []string
	if root == nil {
		return result
	}
	dfs(root, "", &result)
	return result
}

func dfs(node *TreeNode, path string, result *[]string) {
	if node.Left == nil && node.Right == nil {
		*result = append(*result, path+strconv.Itoa(node.Val))
		return
	}
	if node.Left != nil {
		dfs(node.Left, path+strconv.Itoa(node.Val)+"->", result)
	}
	if node.Right != nil {
		dfs(node.Right, path+strconv.Itoa(node.Val)+"->", result)
	}
}