package main


func printTree(root *TreeNode) [][]string {
	if root == nil {
		return [][]string{}
	}
	height := getDepth(root)
	width := 1<<height - 1
	result := make([][]string, height)
	for i := range result {
		result[i] = make([]string, width)
	}
	fill(result, root, 0, 0, width-1)
	return result
}

func getDepth(node *TreeNode) int {
	if node == nil {
		return 0
	}
	return 1 + max(getDepth(node.Left), getDepth(node.Right))
}

func fill(result [][]string, node *TreeNode, depth int, left int, right int) {
	if node == nil {
		return
	}
	mid := (left + right) / 2
	result[depth][mid] = strconv.Itoa(node.Val)
	fill(result, node.Left, depth+1, left, mid-1)
	fill(result, node.Right, depth+1, mid+1, right)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}