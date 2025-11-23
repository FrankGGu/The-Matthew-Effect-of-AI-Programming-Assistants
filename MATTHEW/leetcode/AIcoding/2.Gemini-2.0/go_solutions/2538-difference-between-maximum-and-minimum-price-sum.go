func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func maxProfit(n int, prices []int, edges [][]int) int64 {
	adj := make([][]int, n)
	for _, edge := range edges {
		adj[edge[0]] = append(adj[edge[0]], edge[1])
		adj[edge[1]] = append(adj[edge[1]], edge[0])
	}

	maxSum := int64(0)
	visited := make([]bool, n)
	var dfs func(node int, currentSum int64)
	dfs = func(node int, currentSum int64) {
		visited[node] = true
		currentSum += int64(prices[node])
		maxSum = max(int(maxSum), int(currentSum))

		for _, neighbor := range adj[node] {
			if !visited[neighbor] {
				dfs(neighbor, currentSum)
			}
		}
		visited[node] = false
	}

	for i := 0; i < n; i++ {
		dfs(i, 0)
	}

	return maxSum
}