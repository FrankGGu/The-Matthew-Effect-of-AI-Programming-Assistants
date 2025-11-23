package main

func longestPath(parent []int, s string) int {
	n := len(parent)
	adj := make([][]int, n)
	for i := 1; i < n; i++ {
		adj[parent[i]] = append(adj[parent[i]], i)
	}

	maxPath := 1

	var dfs func(u int) int
	dfs = func(u int) int {
		firstLongest := 0
		secondLongest := 0

		for _, v := range adj[u] {
			pathFromChild := dfs(v)
			if s[u] != s[v] {
				if pathFromChild > firstLongest {
					secondLongest = firstLongest
					firstLongest = pathFromChild
				} else if pathFromChild > secondLongest {
					secondLongest = pathFromChild
				}
			}
		}

		maxPath = max(maxPath, 1+firstLongest+secondLongest)

		return 1 + firstLongest
	}

	dfs(0)
	return maxPath
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}