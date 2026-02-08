import "sort"

func countRestrictedPaths(n int, edges [][]int) int {
	const mod = 1_000_000_007
	graph := make([][][]int, n+1)
	for _, edge := range edges {
		graph[edge[0]] = append(graph[edge[0]], []int{edge[1], edge[2]})
		graph[edge[1]] = append(graph[edge[1]], []int{edge[0], edge[2]})
	}

	dist := make([]int, n+1)
	for i := 1; i <= n; i++ {
		dist[i] = 1<<31 - 1
	}
	dist[n] = 0

	dijkstra := func() {
		type pair struct {
			node, distance int
		}
		pq := []pair{{n, 0}}
		for len(pq) > 0 {
			sort.Slice(pq, func(i, j int) bool {
				return pq[i].distance < pq[j].distance
			})
			curr := pq[0]
			pq = pq[1:]
			if curr.distance > dist[curr.node] {
				continue
			}
			for _, nei := range graph[curr.node] {
				if dist[curr.node]+nei[1] < dist[nei[0]] {
					dist[nei[0]] = dist[curr.node] + nei[1]
					pq = append(pq, pair{nei[0], dist[nei[0]]})
				}
			}
		}
	}

	dijkstra()

	dp := make([]int, n+1)
	dp[n] = 1
	for i := n - 1; i >= 1; i-- {
		for _, nei := range graph[i] {
			if dist[i] > dist[nei[0]] {
				dp[i] = (dp[i] + dp[nei[0]]) % mod
			}
		}
	}
	return dp[1]
}