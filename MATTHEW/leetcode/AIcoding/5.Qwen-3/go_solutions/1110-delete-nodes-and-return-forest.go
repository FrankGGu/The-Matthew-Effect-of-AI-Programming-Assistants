package main


func delNodes(root *TreeNode, toDelete []int) []*TreeNode {
	deleteSet := make(map[int]bool)
	for _, val := range toDelete {
		deleteSet[val] = true
	}
	result := []*TreeNode{}
	var dfs func(*TreeNode, bool) *TreeNode
	dfs = func(node *TreeNode, isRoot bool) *TreeNode {
		if node == nil {
			return nil
		}
		delete := deleteSet[node.Val]
		if delete {
			node.Left = dfs(node.Left, true)
			node.Right = dfs(node.Right, true)
			return nil
		} else {
			node.Left = dfs(node.Left, false)
			node.Right = dfs(node.Right, false)
			if isRoot {
				result = append(result, node)
			}
			return node
		}
	}
	dfs(root, true)
	return result
}