package main

import (
	"sort"
)

type Edge struct {
	u, v, weight int
	index        int
}

type UnionFind struct {
	parent []int
	rank   []int
}

func NewUnionFind(n int) *UnionFind {
	parent := make([]int, n)
	rank := make([]int, n)
	for i := range parent {
		parent[i] = i
	}
	return &UnionFind{parent: parent, rank: rank}
}

func (uf *UnionFind) Find(x int) int {
	if uf.parent[x] != x {
		uf.parent[x] = uf.Find(uf.parent[x])
	}
	return uf.parent[x]
}

func (uf *UnionFind) Union(x, y int) bool {
	rootX := uf.Find(x)
	rootY := uf.Find(y)
	if rootX == rootY {
		return false
	}
	if uf.rank[rootX] > uf.rank[rootY] {
		uf.parent[rootY] = rootX
	} else if uf.rank[rootX] < uf.rank[rootY] {
		uf.parent[rootX] = rootY
	} else {
		uf.parent[rootY] = rootX
		uf.rank[rootX]++
	}
	return true
}

func Kruskal(n int, edges []Edge, ignoreEdgeIndex int, includeEdgeIndex int) (int, int) {
	uf := NewUnionFind(n)
	totalWeight := 0
	if includeEdgeIndex != -1 {
		totalWeight += edges[includeEdgeIndex].weight
		uf.Union(edges[includeEdgeIndex].u, edges[includeEdgeIndex].v)
	}
	for i, edge := range edges {
		if i == ignoreEdgeIndex {
			continue
		}
		if uf.Union(edge.u, edge.v) {
			totalWeight += edge.weight
		}
	}
	return totalWeight, uf
}

func findCriticalAndPseudoCriticalEdges(n int, edges [][]int) [][]int {
	edgeList := make([]Edge, len(edges))
	for i, edge := range edges {
		edgeList[i] = Edge{edge[0], edge[1], edge[2], i}
	}
	sort.Slice(edgeList, func(i, j int) bool {
		return edgeList[i].weight < edgeList[j].weight
	})

	mstWeight, _ := Kruskal(n, edgeList, -1, -1)
	critical := []int{}
	pseudoCritical := []int{}

	for i := 0; i < len(edgeList); i++ {
		if _, uf := Kruskal(n, edgeList, i, -1); uf.Find(edgeList[i].u) == uf.Find(edgeList[i].v) {
			continue
		}
		if kruskalWeight, _ := Kruskal(n, edgeList, i, -1); kruskalWeight != mstWeight {
			critical = append(critical, edgeList[i].index)
		} else {
			if kruskalWeight, _ := Kruskal(n, edgeList, -1, i); kruskalWeight == mstWeight {
				pseudoCritical = append(pseudoCritical, edgeList[i].index)
			}
		}
	}
	return [][]int{critical, pseudoCritical}
}