func catMouseGame(graph [][]int) int {
	n := len(graph)
	dp := make([][][]int, n)
	for i := 0; i < n; i++ {
		dp[i] = make([][]int, n)
		for j := 0; j < n; j++ {
			dp[i][j] = make([]int, 2)
		}
	}

	var dfs func(cat, mouse, turn int) int
	dfs = func(cat, mouse, turn int) int {
		if dp[cat][mouse][turn] != 0 {
			return dp[cat][mouse][turn]
		}
		if cat == mouse {
			dp[cat][mouse][turn] = 1
			return 1
		}
		if turn == 0 {
			for _, nextCat := range graph[cat] {
				if nextCat == 0 {
					continue
				}
				if dfs(nextCat, mouse, 1) == -1 {
					dp[cat][mouse][turn] = 1
					return 1
				}
			}
			dp[cat][mouse][turn] = -1
			return -1
		} else {
			for _, nextMouse := range graph[mouse] {
				if nextMouse == 0 {
					dp[cat][mouse][turn] = 1
					return 1
				}
				if dfs(cat, nextMouse, 0) == 1 {
					dp[cat][mouse][turn] = -1
					return -1
				}
			}
			dp[cat][mouse][turn] = 0
			return 0
		}
	}

	return dfs(1, 2, 0)
}