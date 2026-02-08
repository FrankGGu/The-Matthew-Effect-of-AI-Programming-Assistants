package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func assignTasks(root *TreeNode, tasks []int) int {
	if root == nil {
		return 0
	}
	var taskMap map[int]*TreeNode
	taskMap = make(map[int]*TreeNode)
	for _, task := range tasks {
		taskMap[task] = nil
	}
	var result int
	var dfs func(*TreeNode, int)
	dfs = func(node *TreeNode, level int) {
		if node == nil {
			return
		}
		if task, ok := taskMap[level]; ok {
			result++
			taskMap[level] = node
		}
		dfs(node.Left, level+1)
		dfs(node.Right, level+1)
	}
	dfs(root, 0)
	return result
}