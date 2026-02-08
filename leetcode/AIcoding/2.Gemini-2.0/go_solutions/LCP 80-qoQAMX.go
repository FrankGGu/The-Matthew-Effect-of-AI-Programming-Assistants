func evolutionaryRecord(parents []int) int {
	n := len(parents)
	children := make([]int, n)
	for _, p := range parents {
		if p != -1 {
			children[p]++
		}
	}

	roots := 0
	for i := 0; i < n; i++ {
		if parents[i] == -1 {
			roots++
		}
	}

	if roots == 0 {
		return n
	}

	graph := make([][]int, n)
	for i := 0; i < n; i++ {
		if parents[i] != -1 {
			graph[parents[i]] = append(graph[parents[i]], i)
		}
	}

	memo := make([]int, n)

	var dfs func(node int) int
	dfs = func(node int) int {
		if memo[node] != 0 {
			return memo[node]
		}

		if len(graph[node]) == 0 {
			memo[node] = 1
			return 1
		}

		include := 1
		exclude := 0

		for _, child := range graph[node] {
			include += dfs(child)
			exclude += max(dfs(child), 1)
		}

		memo[node] = max(include, exclude)
		return memo[node]
	}

	ans := 0
	for i := 0; i < n; i++ {
		if parents[i] == -1 {
			ans += dfs(i)
		}
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}