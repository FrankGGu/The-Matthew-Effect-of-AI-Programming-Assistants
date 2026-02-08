package main

import "sort"

func numberOfGoodPaths(vals []int, edges [][]int) int {
	n := len(vals)
	parents := make([]int, n)
	for i := range parents {
		parents[i] = i
	}
	sort.Slice(edges, func(i, j int) bool {
		return max(vals[edges[i][0]], vals[edges[i][1]]) < max(vals[edges[j][0]], vals[edges[j][1]])
	})

	count := make([]int, n)
	for i := 0; i < n; i++ {
		count[i] = 1
	}

	var find func(int) int
	find = func(x int) int {
		if parents[x] != x {
			parents[x] = find(parents[x])
		}
		return parents[x]
	}

	res := n
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		rootU := find(u)
		rootV := find(v)

		if vals[u] == vals[v] {
			res += count[rootU] * count[rootV]
			count[rootU] += count[rootV]
			parents[rootV] = rootU
		} else if vals[u] < vals[v] {
			parents[rootV] = rootU
		} else {
			parents[rootU] = rootV
		}
	}

	return res
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}