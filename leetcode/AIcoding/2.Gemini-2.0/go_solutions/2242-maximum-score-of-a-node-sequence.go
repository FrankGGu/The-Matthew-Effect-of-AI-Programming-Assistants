import "sort"

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

	maxScore := -1
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		for _, a := range adj[u] {
			if a == v {
				continue
			}
			for _, b := range adj[v] {
				if b == u || b == a {
					continue
				}
				score := scores[u] + scores[v] + scores[a] + scores[b]
				if score > maxScore {
					maxScore = score
				}
			}
		}
	}

	return maxScore
}