type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func pseudoPalindromicPaths(root *TreeNode) int {
	count := 0
	var dfs func(*TreeNode, map[int]int)

	dfs = func(node *TreeNode, freq map[int]int) {
		if node == nil {
			return
		}

		freq[node.Val]++

		if node.Left == nil && node.Right == nil {
			oddCount := 0
			for _, v := range freq {
				if v%2 != 0 {
					oddCount++
				}
			}
			if oddCount <= 1 {
				count++
			}
		} else {
			dfs(node.Left, copyMap(freq))
			dfs(node.Right, copyMap(freq))
		}
	}

	dfs(root, make(map[int]int))
	return count
}

func copyMap(m map[int]int) map[int]int {
	newMap := make(map[int]int)
	for k, v := range m {
		newMap[k] = v
	}
	return newMap
}