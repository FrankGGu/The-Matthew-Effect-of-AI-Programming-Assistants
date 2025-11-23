type QueueItem struct {
	node  int
	color int
}

func shortestAlternatingPaths(n int, redEdges [][]int, blueEdges [][]int) []int {
	graph := make([][][]int, n)
	for _, edge := range redEdges {
		graph[edge[0]] = append(graph[edge[0]], []int{edge[1], 0})
	}
	for _, edge := range blueEdges {
		graph[edge[0]] = append(graph[edge[0]], []int{edge[1], 1})
	}

	dist := make([][]int, n)
	for i := range dist {
		dist[i] = []int{-1, -1}
	}
	dist[0] = []int{0, 0}

	queue := []QueueItem{{0, -1}}
	for len(queue) > 0 {
		item := queue[0]
		queue = queue[1:]

		for _, next := range graph[item.node] {
			if item.color == -1 || item.color != next[1] {
				if dist[next[0]][next[1]] == -1 {
					dist[next[0]][next[1]] = dist[item.node][item.color+1] + 1
					queue = append(queue, QueueItem{next[0], next[1]})
				}
			}
		}
	}

	result := make([]int, n)
	for i := 0; i < n; i++ {
		if dist[i][0] == -1 && dist[i][1] == -1 {
			result[i] = -1
		} else if dist[i][0] == -1 {
			result[i] = dist[i][1]
		} else if dist[i][1] == -1 {
			result[i] = dist[i][0]
		} else {
			result[i] = min(dist[i][0], dist[i][1])
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