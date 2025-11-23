func maxNumEdgesToRemove(n int, edges [][]int) int {
	parentA := make([]int, n+1)
	parentB := make([]int, n+1)
	for i := 1; i <= n; i++ {
		parentA[i] = i
		parentB[i] = i
	}

	var find func([]int, int) int
	find = func(parent []int, x int) int {
		if parent[x] != x {
			parent[x] = find(parent, parent[x])
		}
		return parent[x]
	}

	var union func([]int, int, int) bool
	union = func(parent []int, x, y int) bool {
		rootX := find(parent, x)
		rootY := find(parent, y)
		if rootX != rootY {
			parent[rootX] = rootY
			return true
		}
		return false
	}

	removedEdges := 0
	edgesNeeded := 0

	for _, edge := range edges {
		if edge[0] == 3 {
			if union(parentA, edge[1], edge[2]) {
				union(parentB, edge[1], edge[2])
				edgesNeeded++
			} else {
				removedEdges++
			}
		}
	}

	for _, edge := range edges {
		if edge[0] == 1 {
			if union(parentA, edge[1], edge[2]) {
				edgesNeeded++
			} else {
				removedEdges++
			}
		} else if edge[0] == 2 {
			if union(parentB, edge[1], edge[2]) {
				edgesNeeded++
			} else {
				removedEdges++
			}
		}
	}

	root := find(parentA, 1)
	for i := 2; i <= n; i++ {
		if find(parentA, i) != root {
			return -1
		}
	}

	root = find(parentB, 1)
	for i := 2; i <= n; i++ {
		if find(parentB, i) != root {
			return -1
		}
	}

	return removedEdges
}