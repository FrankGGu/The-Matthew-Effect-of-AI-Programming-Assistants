import "math"

func minimumCost(source string, target string, original []string, changed []string, cost []int) int64 {
	n := len(source)
	m := len(target)
	if n != m {
		return -1
	}

	dist := make([][]int, 26)
	for i := range dist {
		dist[i] := make([]int, 26)
		for j := range dist[i] {
			if i == j {
				dist[i][j] = 0
			} else {
				dist[i][j] = math.MaxInt32
			}
		}
	}

	for i := range original {
		if len(original[i]) == 1 && len(changed[i]) == 1 {
			u := original[i][0] - 'a'
			v := changed[i][0] - 'a'
			dist[u][v] = min(dist[u][v], cost[i])
		}
	}

	for k := 0; k < 26; k++ {
		for i := 0; i < 26; i++ {
			for j := 0; j < 26; j++ {
				if dist[i][k] != math.MaxInt32 && dist[k][j] != math.MaxInt32 {
					dist[i][j] = min(dist[i][j], dist[i][k]+dist[k][j])
				}
			}
		}
	}

	graph := make(map[string]map[string]int)
	for i := range original {
		if _, ok := graph[original[i]]; !ok {
			graph[original[i]] = make(map[string]int)
		}
		graph[original[i]][changed[i]] = cost[i]
	}

	dp := make([]int64, n+1)
	for i := 1; i <= n; i++ {
		dp[i] = math.MaxInt64
		if source[i-1] == target[i-1] {
			dp[i] = dp[i-1]
		} else {
			if dist[source[i-1]-'a'][target[i-1]-'a'] != math.MaxInt32 {
				dp[i] = min64(dp[i], dp[i-1]+int64(dist[source[i-1]-'a'][target[i-1]-'a']))
			}
		}

		for j := 1; j <= i; j++ {
			subSource := source[i-j : i]
			subTarget := target[i-j : i]

			if subSource == subTarget {
				dp[i] = min64(dp[i], dp[i-j])
			} else if c, ok := graph[subSource]; ok {
				if cost, ok2 := c[subTarget]; ok2 {
					dp[i] = min64(dp[i], dp[i-j]+int64(cost))
				}
			}
		}
	}

	if dp[n] == math.MaxInt64 {
		return -1
	}
	return dp[n]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func min64(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}