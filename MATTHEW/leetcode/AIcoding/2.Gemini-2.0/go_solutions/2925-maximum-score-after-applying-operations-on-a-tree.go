import "math"

func maximumScoreAfterApplyingOperations(edges [][]int, values []int) int64 {
	n := len(values)
	graph := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
	}

	dp := make([][]int64, n)
	for i := range dp {
		dp[i] = make([]int64, 2)
	}

	var dfs func(node, parent int)
	dfs = func(node, parent int) {
		dp[node][1] = int64(values[node])
		dp[node][0] = 0

		for _, neighbor := range graph[node] {
			if neighbor != parent {
				dfs(neighbor, node)
				dp[node][1] += min(dp[neighbor][0], dp[neighbor][1])
				dp[node][0] += dp[neighbor][1]
			}
		}
	}

	dfs(0, -1)
	return max(dp[0][0], dp[0][1])
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}