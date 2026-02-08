import "math"

func findMinHeightTrees(n int, edges [][]int) []int {
	if n == 1 {
		return []int{0}
	}
	graph := make([][]int, n)
	degrees := make([]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
		degrees[u]++
		degrees[v]++
	}

	queue := []int{}
	for i := 0; i < n; i++ {
		if degrees[i] == 1 {
			queue = append(queue, i)
		}
	}

	remainingNodes := n
	for remainingNodes > 2 {
		size := len(queue)
		remainingNodes -= size
		for i := 0; i < size; i++ {
			node := queue[i]
			for _, neighbor := range graph[node] {
				degrees[neighbor]--
				if degrees[neighbor] == 1 {
					queue = append(queue, neighbor)
				}
			}
		}
		queue = queue[size:]
	}

	return queue
}

func treeDiameter(n int, edges [][]int) int {
	if n == 1 {
		return 0
	}

	graph := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
	}

	bfs := func(start int) (int, int) {
		dist := make([]int, n)
		for i := 0; i < n; i++ {
			dist[i] = -1
		}
		dist[start] = 0
		queue := []int{start}
		maxDist := 0
		farthestNode := start

		for len(queue) > 0 {
			u := queue[0]
			queue = queue[1:]

			for _, v := range graph[u] {
				if dist[v] == -1 {
					dist[v] = dist[u] + 1
					queue = append(queue, v)
					if dist[v] > maxDist {
						maxDist = dist[v]
						farthestNode = v
					}
				}
			}
		}
		return farthestNode, maxDist
	}

	node1, _ := bfs(0)
	node2, diameter := bfs(node1)
	_ = node2

	return diameter
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func findMinDiameter(n1 int, n2 int, edges1 [][]int, edges2 [][]int) int {
	diameter1 := treeDiameter(n1, edges1)
	diameter2 := treeDiameter(n2, edges2)

	t1 := findMinHeightTrees(n1, edges1)
	t2 := findMinHeightTrees(n2, edges2)

	minDiameter := math.MaxInt32
	for _, r1 := range t1 {
		for _, r2 := range t2 {
			diameter := max(diameter1, max(diameter2, findPathDiameter(n1, n2, edges1, edges2, r1, r2)))
			minDiameter = min(minDiameter, diameter)

		}
	}

	if minDiameter == math.MaxInt32 {
		return -1
	}

	return minDiameter
}

func findPathDiameter(n1 int, n2 int, edges1 [][]int, edges2 [][]int, r1 int, r2 int) int {
	n := n1 + n2
	graph := make([][]int, n)

	for _, edge := range edges1 {
		u, v := edge[0], edge[1]
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
	}
	for _, edge := range edges2 {
		u, v := edge[0]+n1, edge[1]+n1
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
	}

	graph[r1] = append(graph[r1], r2+n1)
	graph[r2+n1] = append(graph[r2+n1], r1)

	bfs := func(start int) (int, int) {
		dist := make([]int, n)
		for i := 0; i < n; i++ {
			dist[i] = -1
		}
		dist[start] = 0
		queue := []int{start}
		maxDist := 0
		farthestNode := start

		for len(queue) > 0 {
			u := queue[0]
			queue = queue[1:]

			for _, v := range graph[u] {
				if dist[v] == -1 {
					dist[v] = dist[u] + 1
					queue = append(queue, v)
					if dist[v] > maxDist {
						maxDist = dist[v]
						farthestNode = v
					}
				}
			}
		}
		return farthestNode, maxDist
	}

	node1, _ := bfs(0)
	node2, diameter := bfs(node1)
	_ = node2

	return diameter
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}