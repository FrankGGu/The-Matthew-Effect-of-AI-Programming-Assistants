package main


func minDiffInBST(root *TreeNode) int {
	var prev *TreeNode
	minDiff := 1<<31 - 1

	var dfs func(*TreeNode)
	dfs = func(node *TreeNode) {
		if node == nil {
			return
		}
		dfs(node.Left)
		if prev != nil {
			minDiff = min(minDiff, node.Val-prev.Val)
		}
		prev = node
		dfs(node.Right)
	}

	dfs(root)
	return minDiff
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}