type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func pathSum(root *TreeNode, targetSum int) [][]int {
	result := [][]int{}
	var dfs func(*TreeNode, int, []int)

	dfs = func(node *TreeNode, currentSum int, path []int) {
		if node == nil {
			return
		}

		currentSum += node.Val
		path = append(path, node.Val)

		if node.Left == nil && node.Right == nil {
			if currentSum == targetSum {
				newPath := make([]int, len(path))
				copy(newPath, path)
				result = append(result, newPath)
			}
			return
		}

		dfs(node.Left, currentSum, path)
		dfs(node.Right, currentSum, path)
	}

	dfs(root, 0, []int{})
	return result
}