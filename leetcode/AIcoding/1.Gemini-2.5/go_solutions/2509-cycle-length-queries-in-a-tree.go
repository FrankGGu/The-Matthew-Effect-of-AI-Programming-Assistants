package main

import (
	"math"
)

var (
	depth  []int
	parent [][]int
	maxLog int
	nNodes int
)

func getLCA(u, v int) int {
	if depth[u] < depth[v] {
		u, v = v, u
	}

	for k := maxLog; k >= 0; k-- {
		if depth[u]-(1<<k) >= depth[v] {
			u = parent[k][u]
		}
	}

	if u == v {
		return u
	}

	for k := maxLog; k >= 0; k-- {
		if parent[k][u] != 0 && parent[k][u] != parent[k][v] {
			u = parent[k][u]
			v = parent[k][v]
		}
	}

	return parent[0][u]
}

func cycleLengthQueries(n int, queries [][]int) []int {
	nNodes = n
	maxLog = int(math.Log2(float64(n))) + 1

	depth = make([]int, n+1)
	parent = make([][]int, maxLog+1)
	for i := range parent {
		parent[i] = make([]int, n+1)
	}

	depth[1] = 0
	parent[0][1] = 0 // Dummy parent for root

	for i := 2; i <= n; i++ {
		parent[0][i] = i / 2
		depth[i] = depth[i/2] + 1
	}

	for k := 1; k <= maxLog; k++ {
		for i := 1; i <= n; i++ {
			if parent[k-1][i] != 0 {
				parent[k][i] = parent[k-1][parent[k-1][i]]
			}
		}
	}

	results := make([]int, len(queries))
	for i, q := range queries {
		u, v := q[0], q[1]
		lcaNode := getLCA(u, v)
		results[i] = depth[u] + depth[v] - 2*depth[lcaNode] + 1
	}

	return results
}