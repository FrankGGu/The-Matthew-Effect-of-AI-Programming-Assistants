import "math"

func networkDelayTime(times [][]int, n int, k int) int {
	graph := make([][]int, n+1)
	for i := range graph {
		graph[i] = make([]int, n+1)
		for j := range graph[i] {
			graph[i][j] = math.MaxInt32
		}
	}
	for _, time := range times {
		u, v, w := time[0], time[1], time[2]
		graph[u][v] = w
	}

	dist := make([]int, n+1)
	for i := range dist {
		dist[i] = math.MaxInt32
	}
	dist[k] = 0

	visited := make([]bool, n+1)

	for i := 1; i <= n; i++ {
		u := -1
		for v := 1; v <= n; v++ {
			if !visited[v] && (u == -1 || dist[v] < dist[u]) {
				u = v
			}
		}

		if u == -1 {
			break
		}

		visited[u] = true

		for v := 1; v <= n; v++ {
			if graph[u][v] != math.MaxInt32 && dist[u] != math.MaxInt32 && dist[u]+graph[u][v] < dist[v] {
				dist[v] = dist[u] + graph[u][v]
			}
		}
	}

	maxDelay := 0
	for i := 1; i <= n; i++ {
		if dist[i] == math.MaxInt32 {
			return -1
		}
		maxDelay = max(maxDelay, dist[i])
	}

	return maxDelay
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}