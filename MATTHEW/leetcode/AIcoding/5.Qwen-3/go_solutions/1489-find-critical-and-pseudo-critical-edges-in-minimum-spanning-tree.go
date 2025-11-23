package main

import (
	"sort"
)

func findCriticalAndPseudoCriticalEdges(n int, edges [][]int) [][]int {
	type edge struct {
		u, v, w, idx int
	}
	edgesWithIndex := make([]edge, len(edges))
	for i, e := range edges {
		edgesWithIndex[i] = edge{e[0], e[1], e[2], i}
	}

	sort.Slice(edgesWithIndex, func(i, j int) bool {
		return edgesWithIndex[i].w < edgesWithIndex[j].w
	})

	parent := make([]int, n)
	var find func(x int) int
	find = func(x int) int {
		if parent[x] != x {
			parent[x] = find(parent[x])
		}
		return parent[x]
	}

	var kruskal func(edges []edge, exclude int) int
	kruskal = func(edges []edge, exclude int) int {
		for i := range parent {
			parent[i] = i
		}
		totalWeight := 0
		count := 0
		for _, e := range edges {
			if e.idx == exclude {
				continue
			}
			rootU := find(e.u)
			rootV := find(e.v)
			if rootU != rootV {
				parent[rootU] = rootV
				totalWeight += e.w
				count++
			}
		}
		if count != n-1 {
			return -1
		}
		return totalWeight
	}

	minWeight := kruskal(edgesWithIndex, -1)

	critical := make([]int, 0)
	pseudoCritical := make([]int, 0)

	for _, e := range edgesWithIndex {
		weight := kruskal(edgesWithIndex, e.idx)
		if weight == -1 || weight > minWeight {
			critical = append(critical, e.idx)
		} else {
			weightWith := kruskalWithEdge(edgesWithIndex, e.idx, n)
			if weightWith == minWeight {
				pseudoCritical = append(pseudoCritical, e.idx)
			}
		}
	}

	sort.Ints(critical)
	sort.Ints(pseudoCritical)

	return [][]int{critical, pseudoCritical}
}

func kruskalWithEdge(edges []edge, include int, n int) int {
	for i := range parent {
		parent[i] = i
	}
	totalWeight := 0
	count := 0
	e := edges[include]
	rootU := find(e.u)
	rootV := find(e.v)
	if rootU != rootV {
		parent[rootU] = rootV
		totalWeight += e.w
		count++
	}
	for _, e := range edges {
		if e.idx == include {
			continue
		}
		rootU := find(e.u)
		rootV := find(e.v)
		if rootU != rootV {
			parent[rootU] = rootV
			totalWeight += e.w
			count++
		}
	}
	if count != n-1 {
		return -1
	}
	return totalWeight
}