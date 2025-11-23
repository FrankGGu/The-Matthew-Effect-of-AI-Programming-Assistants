func findRedundantDirectedConnection(edges [][]int) []int {
	n := len(edges)
	parent := make([]int, n+1)
	inDegree := make([]int, n+1)
	var candidate1, candidate2 []int

	for _, edge := range edges {
		u, v := edge[0], edge[1]
		inDegree[v]++
	}

	for i := n - 1; i >= 0; i-- {
		if inDegree[edges[i][1]] > 1 {
			candidate2 = edges[i]
			edges = append(edges[:i], edges[i+1:]...)
			break
		}
	}

	for i := 1; i <= n; i++ {
		parent[i] = i
	}

	var find func(int) int
	find = func(x int) int {
		if parent[x] != x {
			parent[x] = find(parent[x])
		}
		return parent[x]
	}

	union := func(x, y int) bool {
		rootX := find(x)
		rootY := find(y)
		if rootX == rootY {
			return false
		}
		parent[rootX] = rootY
		return true
	}

	for _, edge := range edges {
		u, v := edge[0], edge[1]
		if !union(u, v) {
			candidate1 = edge
			break
		}
	}

	if candidate2 == nil {
		return candidate1
	}

	for i := 1; i <= n; i++ {
		parent[i] = i
	}

	cycleDetected := false
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		if !union(u, v) {
			cycleDetected = true
			break
		}
	}

	if cycleDetected {
		return candidate1
	}
	return candidate2
}