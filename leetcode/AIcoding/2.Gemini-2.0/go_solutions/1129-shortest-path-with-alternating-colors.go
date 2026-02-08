func shortestAlternatingPaths(n int, redEdges [][]int, blueEdges [][]int) []int {
	adj := make([][][]int, 2)
	adj[0] = make([][]int, n)
	adj[1] = make([][]int, n)

	for _, edge := range redEdges {
		adj[0][edge[0]] = append(adj[0][edge[0]], edge[1])
	}
	for _, edge := range blueEdges {
		adj[1][edge[0]] = append(adj[1][edge[0]], edge[1])
	}

	dist := make([][]int, 2)
	dist[0] = make([]int, n)
	dist[1] = make([]int, n)
	for i := 0; i < n; i++ {
		dist[0][i] = -1
		dist[1][i] = -1
	}

	q := [][]int{{0, 0}, {0, 1}}
	dist[0][0] = 0
	dist[1][0] = 0

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]
		node := curr[0]
		color := curr[1]
		d := dist[color][node]

		nextColor := 1 - color

		for _, neighbor := range adj[nextColor][node] {
			if dist[nextColor][neighbor] == -1 {
				dist[nextColor][neighbor] = d + 1
				q = append(q, []int{neighbor, nextColor})
			}
		}
	}

	result := make([]int, n)
	for i := 0; i < n; i++ {
		r := dist[0][i]
		b := dist[1][i]
		if r == -1 && b == -1 {
			result[i] = -1
		} else if r == -1 {
			result[i] = b
		} else if b == -1 {
			result[i] = r
		} else {
			result[i] = min(r, b)
		}
	}

	return result
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}