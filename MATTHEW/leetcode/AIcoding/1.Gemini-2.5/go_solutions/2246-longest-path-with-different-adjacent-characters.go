package main

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func longestPath(parent []int, s string) int {
	n := len(parent)
	adj := make([][]int, n)
	for i := 1; i < n; i++ {
		adj[parent[i]] = append(adj[parent[i]], i)
		adj[i] = append(adj[i], parent[i])
	}

	maxPath := 1

	var dfs func(u, p int) int
	dfs = func(u, p int) int {
		longestBranch1 := 0
		longestBranch2 := 0

		for _, v := range adj[u] {
			if v == p {
				continue
			}

			childPathLen := dfs(v, u)

			if s[u] != s[v] {
				if childPathLen > longestBranch1 {
					longestBranch2 = longestBranch1
					longestBranch1 = childPathLen
				} else if childPathLen > longestBranch2 {
					longestBranch2 = childPathLen
				}
			}
		}

		maxPath = max(maxPath, 1+longestBranch1+longestBranch2)

		return 1 + longestBranch1
	}

	dfs(0, -1)

	return maxPath
}