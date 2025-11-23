func catMouseGame(graph [][]int) int {
	n := len(graph)
	dp := make([][][]int, n)
	for i := range dp {
		dp[i] = make([][]int, n)
		for j := range dp[i] {
			dp[i][j] = make([]int, 2*n)
			for k := range dp[i][j] {
				dp[i][j][k] = 0
			}
		}
	}

	var getResult func(mouse int, cat int, turn int) int
	getResult = func(mouse int, cat int, turn int) int {
		if turn == 2*n {
			return 0
		}
		if dp[mouse][cat][turn] != 0 {
			return dp[mouse][cat][turn]
		}
		if mouse == 0 {
			dp[mouse][cat][turn] = 1
			return 1
		}
		if mouse == cat {
			dp[mouse][cat][turn] = 2
			return 2
		}

		if turn%2 == 0 {
			// Mouse's turn
			win := false
			draw := true
			for _, nextMouse := range graph[mouse] {
				result := getResult(nextMouse, cat, turn+1)
				if result == 1 {
					dp[mouse][cat][turn] = 1
					return 1
				} else if result == 0 {
					win = true
				}
			}
			if win {
				dp[mouse][cat][turn] = 0
				return 0
			} else {
				dp[mouse][cat][turn] = 2
				return 2
			}
		} else {
			// Cat's turn
			lose := false
			draw := true
			for _, nextCat := range graph[cat] {
				if nextCat != 0 {
					result := getResult(mouse, nextCat, turn+1)
					if result == 2 {
						dp[mouse][cat][turn] = 2
						return 2
					} else if result == 0 {
						lose = true
					}
				}
			}
			if lose {
				dp[mouse][cat][turn] = 0
				return 0
			} else {
				dp[mouse][cat][turn] = 1
				return 1
			}
		}
	}

	return getResult(1, 2, 0)
}