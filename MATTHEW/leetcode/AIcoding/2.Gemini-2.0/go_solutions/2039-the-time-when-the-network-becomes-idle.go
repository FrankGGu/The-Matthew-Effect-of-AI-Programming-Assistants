func networkBecomesIdle(edges [][]int, patience []int) int {
	n := len(patience)
	graph := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
	}

	dist := make([]int, n)
	for i := range dist {
		dist[i] = -1
	}
	dist[0] = 0

	queue := []int{0}
	for len(queue) > 0 {
		u := queue[0]
		queue = queue[1:]
		for _, v := range graph[u] {
			if dist[v] == -1 {
				dist[v] = dist[u] + 1
				queue = append(queue, v)
			}
		}
	}

	maxTime := 0
	for i := 1; i < n; i++ {
		d := dist[i] * 2
		lastSend := (d / patience[i]) * patience[i]
		if d%patience[i] == 0 && d != 0{
			lastSend = (d / patience[i] -1) * patience[i]
		} else if d % patience[i] == 0 && d == 0{
			lastSend = 0
		} else if d == 0{
			lastSend = 0
		}

		arrival := lastSend + d + 1
		if arrival > maxTime {
			maxTime = arrival
		}
	}

	return maxTime
}