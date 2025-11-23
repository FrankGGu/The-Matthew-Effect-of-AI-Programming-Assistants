func makeConnected(n int, connections [][]int) int {
	if len(connections) < n-1 {
		return -1
	}

	parent := make([]int, n)
	for i := range parent {
		parent[i] = i
	}

	var find func(int) int
	find = func(x int) int {
		if parent[x] != x {
			parent[x] = find(parent[x])
		}
		return parent[x]
	}

	union := func(x, y int) {
		rootX := find(x)
		rootY := find(y)
		if rootX != rootY {
			parent[rootX] = rootY
		}
	}

	for _, conn := range connections {
		union(conn[0], conn[1])
	}

	count := 0
	for i := range parent {
		if parent[i] == i {
			count++
		}
	}

	return count - 1
}