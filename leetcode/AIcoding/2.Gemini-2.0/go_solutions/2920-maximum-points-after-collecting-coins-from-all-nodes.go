func maximumPoints(coins []int, edges [][]int, k int) int {
	n := len(coins)
	graph := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
	}

	memo := make([][]int, n)
	for i := range memo {
		memo[i] = make([]int, n+1)
		for j := range memo[i] {
			memo[i][j] = -1
		}
	}

	var dfs func(node, parent, shifts int) int
	dfs = func(node, parent, shifts int) int {
		if memo[node][shifts] != -1 {
			return memo[node][shifts]
		}

		res := 0
		res = max(res, coins[node]>>shifts-k)

		res1 := 0
		res1 = coins[node]>>shifts - k

		res2 := 0
		res2 = coins[node]>>(shifts+1)

		sum1 := 0
		sum2 := 0

		for _, neighbor := range graph[node] {
			if neighbor != parent {

				sum1 += dfs(neighbor, node, shifts)
				sum2 += dfs(neighbor, node, shifts+1)

			}
		}

		res1 += sum1
		res2 += sum2

		res = max(res1, res2)

		memo[node][shifts] = res
		return res
	}

	return dfs(0, -1, 0)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}