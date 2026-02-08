func countVisitedNodes(edges []int) []int {
	n := len(edges)
	ans := make([]int, n)
	visited := make([]bool, n)

	for startNode := 0; startNode < n; startNode++ {
		if ans[startNode] != 0 {
			continue
		}

		path := []int{}
		curr := startNode
		pathMap := make(map[int]int)
		idx := 0

		for !visited[curr] {
			visited[curr] = true
			path = append(path, curr)
			pathMap[curr] = idx
			idx++
			curr = edges[curr]
		}

		cycleStart := pathMap[curr]
		cycleLen := len(path) - cycleStart

		for i := cycleStart; i < len(path); i++ {
			ans[path[i]] = cycleLen
		}

		for i := 0; i < cycleStart; i++ {
			curr := path[i]
			count := 1
			next := edges[curr]
			for ans[next] == 0 {
				count++
				next = edges[next]
			}
			ans[curr] = count + ans[next]
		}

		for _, node := range path {
			visited[node] = false
		}
	}

	return ans
}