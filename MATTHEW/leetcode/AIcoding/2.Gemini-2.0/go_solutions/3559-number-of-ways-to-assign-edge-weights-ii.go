import "sort"

func countPaths(n int, edges [][]int) int64 {
	adj := make([][]int, n+1)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	dp := make([][]int64, n+1)
	for i := 1; i <= n; i++ {
		dp[i] = make([]int64, n+1)
	}

	var dfs func(node, target, parent int, path []int)
	dfs = func(node, target, parent int, path []int) {
		path = append(path, node)
		if node == target {
			for i := 1; i < len(path); i++ {
				u, v := path[i-1], path[i]
				dp[u][v]++
				dp[v][u]++
			}
			return
		}

		for _, neighbor := range adj[node] {
			if neighbor != parent {
				dfs(neighbor, target, node, path)
			}
		}
	}

	for i := 1; i <= n; i++ {
		for j := i + 1; j <= n; j++ {
			dfs(i, j, 0, []int{})
		}
	}

	totalPaths := int64(0)
	for i := 1; i <= n; i++ {
		for j := i + 1; j <= n; j++ {
			if dp[i][j] > 0 {
				totalPaths += dp[i][j]
			}
		}
	}

	return totalPaths
}

func assignMiceHoles(mice []int, holes []int) int {
	sort.Ints(mice)
	sort.Ints(holes)

	maxTime := 0
	for i := 0; i < len(mice); i++ {
		time := abs(mice[i] - holes[i])
		if time > maxTime {
			maxTime = time
		}
	}

	return maxTime
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func waysToAssign(n int, edges [][]int) int64 {
	adj := make([][]int, n+1)
	edgeMap := make(map[int]map[int]int)

	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		if _, ok := edgeMap[u]; !ok {
			edgeMap[u] = make(map[int]int)
		}
		if _, ok := edgeMap[v]; !ok {
			edgeMap[v] = make(map[int]int)
		}
		edgeMap[u][v] = w
		edgeMap[v][u] = w
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	totalPaths := countPaths(n, edges)

	mod := int64(1e9 + 7)
	ans := int64(1)

	for i := 1; i <= n; i++ {
		for j := i + 1; j <= n; j++ {
			count := int64(0)
			for _, edge := range edges {
				u, v, w := edge[0], edge[1], edge[2]
				if (u == i && v == j) || (u == j && v == i) {
					count++
				}
			}
			if count > 0 {
				if edgeMap[i][j] == 2 {
					continue
				} else {
					originalWeight := edgeMap[i][j]
					edgeMap[i][j] = 2
					edgeMap[j][i] = 2
					newTotalPaths := countPaths(n, edges)

					if newTotalPaths < totalPaths {
						ans = (ans * 0) % mod

					} else {
						ans = (ans * count) % mod
					}
					edgeMap[i][j] = originalWeight
					edgeMap[j][i] = originalWeight
				}
			}
		}
	}
	return ans
}