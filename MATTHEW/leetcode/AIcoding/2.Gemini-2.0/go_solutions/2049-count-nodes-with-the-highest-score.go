func countHighestScoreNodes(parents []int) int {
	n := len(parents)
	children := make([][]int, n)
	for i := 1; i < n; i++ {
		children[parents[i]] = append(children[parents[i]], i)
	}

	var maxScore int64 = 0
	var count int = 0

	var dfs func(int) int
	dfs = func(node int) int {
		size := 1
		var score int64 = 1
		for _, child := range children[node] {
			childSize := dfs(child)
			size += childSize
			score *= int64(childSize)
		}

		if node != 0 {
			score *= int64(n - size)
		}

		if score > maxScore {
			maxScore = score
			count = 1
		} else if score == maxScore {
			count++
		}

		return size
	}

	dfs(0)
	return count
}