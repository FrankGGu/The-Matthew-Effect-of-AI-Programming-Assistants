package main

func findRedundantConnection(edges [][]int) []int {
	n := len(edges)
	parent := make([]int, n+1)
	for i := 1; i <= n; i++ {
		parent[i] = i
	}

	var find func(i int) int
	find = func(i int) int {
		if parent[i] == i {
			return i
		}
		parent[i] = find(parent[i])
		return parent[i]
	}

	for _, edge := range edges {
		u, v := edge[0], edge[1]
		rootU := find(u)
		rootV := find(v)

		if rootU == rootV {
			return edge
		}
		parent[rootU] = rootV
	}
	return nil
}