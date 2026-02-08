func numOfMinutes(n int, headID int, manager []int, informTime []int) int {
	adj := make([][]int, n)
	for i := 0; i < n; i++ {
		if manager[i] != -1 {
			adj[manager[i]] = append(adj[manager[i]], i)
		}
	}

	var dfs func(int) int
	dfs = func(node int) int {
		maxTime := 0
		for _, neighbor := range adj[node] {
			maxTime = max(maxTime, dfs(neighbor))
		}
		return informTime[node] + maxTime
	}

	return dfs(headID)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}