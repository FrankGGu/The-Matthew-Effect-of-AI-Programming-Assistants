func maximumScore(scores []int, edges [][]int) int {
	n := len(scores)
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	for i := 0; i < n; i++ {
		sort.Slice(adj[i], func(a, b int) bool {
			return scores[adj[i][a]] > scores[adj[i][b]]
		})
		if len(adj[i]) > 3 {
			adj[i] = adj[i][:3]
		}
	}

	ans := -1
	for i := 0; i < len(edges); i++ {
		u, v := edges[i][0], edges[i][1]
		for _, a := range adj[u] {
			if a == v {
				continue
			}
			for _, b := range adj[v] {
				if b == u || b == a {
					continue
				}
				ans = max(ans, scores[u]+scores[v]+scores[a]+scores[b])
			}
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

import "sort"