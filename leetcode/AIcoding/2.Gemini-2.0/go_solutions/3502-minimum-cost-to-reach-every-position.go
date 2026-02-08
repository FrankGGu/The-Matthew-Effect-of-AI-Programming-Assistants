func minCost(start int, target int, specialRoads [][]int) int {
	graph := make(map[int]map[int]int)
	graph[start] = make(map[int]int)
	graph[start][target] = abs(target - start)

	for _, road := range specialRoads {
		from, to, cost := road[0], road[1], road[2]
		if _, ok := graph[from]; !ok {
			graph[from] = make(map[int]int)
		}
		graph[from][to] = min(abs(to-from), cost)

		if _, ok := graph[start]; !ok {
			graph[start] = make(map[int]int)
		}
		graph[start][from] = abs(from - start)

		if _, ok := graph[to]; !ok {
			graph[to] = make(map[int]int)
		}
		graph[to][target] = abs(target - to)

		if _, ok := graph[target]; !ok {
			graph[target] = make(map[int]int)
		}
		graph[target][to] = abs(target - to)

		if _, ok := graph[target]; !ok {
			graph[target] = make(map[int]int)
		}
		graph[target][from] = abs(target - from)

		if _, ok := graph[from]; !ok {
			graph[from] = make(map[int]int)
		}
		graph[from][target] = abs(target - from)

		if _, ok := graph[to]; !ok {
			graph[to] = make(map[int]int)
		}
		graph[to][start] = abs(start - to)

		if _, ok := graph[start]; !ok {
			graph[start] = make(map[int]int)
		}
		graph[start][to] = abs(to - start)
	}

	nodes := make(map[int]bool)
	nodes[start] = true
	nodes[target] = true

	for _, road := range specialRoads {
		nodes[road[0]] = true
		nodes[road[1]] = true
	}

	for node1 := range nodes {
		for node2 := range nodes {
			if node1 != node2 {
				if _, ok := graph[node1]; !ok {
					graph[node1] = make(map[int]int)
				}
				if _, ok := graph[node1][node2]; !ok {
					graph[node1][node2] = abs(node2 - node1)
				} else {
					graph[node1][node2] = min(graph[node1][node2], abs(node2 - node1))
				}
			}
		}
	}

	dist := make(map[int]int)
	for node := range nodes {
		dist[node] = int(1e18)
	}
	dist[start] = 0

	visited := make(map[int]bool)

	for len(visited) < len(nodes) {
		u := -1
		minDist := int(1e18)

		for node := range nodes {
			if !visited[node] && dist[node] < minDist {
				minDist = dist[node]
				u = node
			}
		}

		if u == -1 {
			break
		}

		visited[u] = true

		for v, weight := range graph[u] {
			if dist[u]+weight < dist[v] {
				dist[v] = dist[u] + weight
			}
		}
	}

	return dist[target]
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}