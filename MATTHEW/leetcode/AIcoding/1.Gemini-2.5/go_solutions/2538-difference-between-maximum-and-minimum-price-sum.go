func maxPriceSum(n int, edges [][]int, prices []int) int64 {
	adj := make([][]int, n)
	var totalSum int64 = 0
	for i := 0; i < n; i++ {
		totalSum += int64(prices[i])
	}

	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	var maxDiff int64 = 0

	var dfs func(u, p int) int64
	dfs = func(u, p int) int64 {
		currentSubtreeSum := int64(prices[u])
		for _, v := range adj[u] {
			if v == p {
				continue
			}
			childSubtreeSum := dfs(v, u)
			currentSubtreeSum += childSubtreeSum

			diff := abs(2*childSubtreeSum - totalSum)
			if diff > maxDiff {
				maxDiff = diff
			}
		}
		return currentSubtreeSum
	}

	dfs(0, -1)

	return maxDiff
}

func abs(x int64) int64 {
	if x < 0 {
		return -x
	}
	return x
}