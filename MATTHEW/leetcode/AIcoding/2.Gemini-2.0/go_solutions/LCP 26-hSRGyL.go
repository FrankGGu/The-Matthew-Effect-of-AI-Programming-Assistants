func minCost(start []int, target []int, specialRoads [][]int) int {
	x1, y1 := start[0], start[1]
	x2, y2 := target[0], target[1]
	dist := abs(x1-x2) + abs(y1-y2)
	if len(specialRoads) == 0 {
		return dist
	}

	graph := make(map[int]map[int]int)
	nodes := make(map[int]bool)

	startNode := (x1+10000)*20001 + (y1+10000)
	targetNode := (x2+10000)*20001 + (y2+10000)
	nodes[startNode] = true
	nodes[targetNode] = true

	graph[startNode] = make(map[int]int)
	graph[targetNode] = make(map[int]int)

	for _, road := range specialRoads {
		x3, y3, x4, y4, cost := road[0], road[1], road[2], road[3], road[4]
		node1 := (x3+10000)*20001 + (y3+10000)
		node2 := (x4+10000)*20001 + (y4+10000)
		nodes[node1] = true
		nodes[node2] = true
		if _, ok := graph[node1]; !ok {
			graph[node1] = make(map[int]int)
		}
		graph[node1][node2] = cost

		dist1 := abs(x1-x3) + abs(y1-y3)
		if _, ok := graph[startNode]; !ok {
			graph[startNode] = make(map[int]int)
		}
		graph[startNode][node1] = dist1

		dist2 := abs(x4-x2) + abs(y4-y2)
		if _, ok := graph[node2]; !ok {
			graph[node2] = make(map[int]int)
		}
		graph[node2][targetNode] = dist2
	}

	for node1 := range nodes {
		for node2 := range nodes {
			if node1 != node2 && graph[node1] == nil {
				graph[node1] = make(map[int]int)
			}

			if node1 != node2 && graph[node1][node2] == 0 {
				x1 := node1 / 20001 - 10000
				y1 := node1 % 20001 - 10000
				x2 := node2 / 20001 - 10000
				y2 := node2 % 20001 - 10000
				graph[node1][node2] = abs(x1-x2) + abs(y1-y2)
			}
		}
	}

	distances := make(map[int]int)
	for node := range nodes {
		distances[node] = int(1e9)
	}
	distances[startNode] = 0

	visited := make(map[int]bool)

	for {
		minNode := -1
		minDist := int(1e9)

		for node := range nodes {
			if !visited[node] && distances[node] < minDist {
				minDist = distances[node]
				minNode = node
			}
		}

		if minNode == -1 {
			break
		}

		visited[minNode] = true

		for neighbor, weight := range graph[minNode] {
			if distances[minNode] + weight < distances[neighbor] {
				distances[neighbor] = distances[minNode] + weight
			}
		}
	}

	return distances[targetNode]
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}