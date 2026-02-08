import (
	"math"
)

func shortestCycle(n int, edges [][]int) int {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	ans := math.MaxInt32

	for i := 0; i < n; i++ {
		dist := make([]int, n)
		parent := make([]int, n)
		for j := 0; j < n; j++ {
			dist[j] = -1
			parent[j] = -1
		}

		q := []int{i}
		dist[i] = 0

		for len(q) > 0 {
			u := q[0]
			q = q[1:]

			for _, v := range adj[u] {
				if dist[v] == -1 {
					dist[v] = dist[u] + 1
					parent[v] = u
					q = append(q, v)
				} else if parent[u] != v && parent[v] != u {
					ans = min(ans, dist[u]+dist[v]+1)
				}
			}
		}
	}

	if ans == math.MaxInt32 {
		return -1
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}