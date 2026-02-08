func findRedundantConnection(edges [][]int) []int {
	n := len(edges)
	parent := make([]int, n+1)
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

	var redundantEdge []int
	for _, edge := range edges {
		if !union(edge[0], edge[1]) {
			redundantEdge = edge
		}
	}
	return redundantEdge
}