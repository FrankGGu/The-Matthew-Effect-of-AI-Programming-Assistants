package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func getDirections(root *TreeNode, startValue int, endValue int) string {
	pathToStart := getPath(root, startValue)
	pathToEnd := getPath(root, endValue)

	i := 0
	for i < len(pathToStart) && i < len(pathToEnd) && pathToStart[i] == pathToEnd[i] {
		i++
	}

	result := ""
	for j := i; j < len(pathToStart); j++ {
		result += "U"
	}
	for j := i; j < len(pathToEnd); j++ {
		result += string(pathToEnd[j])
	}

	return result
}

func getPath(root *TreeNode, target int) []rune {
	var path []rune
	dfs(root, target, &path)
	return path
}

func dfs(node *TreeNode, target int, path *[]rune) bool {
	if node == nil {
		return false
	}
	if node.Val == target {
		return true
	}

	*path = append(*path, 'L')
	if dfs(node.Left, target, path) {
		return true
	}
	*path = (*path)[:len(*path)-1]

	*path = append(*path, 'R')
	if dfs(node.Right, target, path) {
		return true
	}
	*path = (*path)[:len(*path)-1]

	return false
}