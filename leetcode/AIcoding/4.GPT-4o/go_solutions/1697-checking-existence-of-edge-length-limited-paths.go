package main

import (
	"container/heap"
)

type Query struct {
	src, dst, limit, index int
}

type Edge struct {
	to, weight int
}

type MinHeap []Edge

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].weight < h[j].weight }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Edge))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func distanceLimitedPathsExist(n int, edgeList [][]int, queries [][]int) []bool {
	edges := make([]Edge, len(edgeList))
	for i, e := range edgeList {
		edges[i] = Edge{to: e[1], weight: e[2]}
	}

	qList := make([]Query, len(queries))
	for i, q := range queries {
		qList[i] = Query{src: q[0], dst: q[1], limit: q[2], index: i}
	}

	sort.Slice(edges, func(i, j int) bool {
		return edges[i].weight < edges[j].weight
	})

	sort.Slice(qList, func(i, j int) bool {
		return qList[i].limit < qList[j].limit
	})

	result := make([]bool, len(queries))
	uf := NewUnionFind(n)
	edgeIndex := 0

	for _, q := range qList {
		for edgeIndex < len(edges) && edges[edgeIndex].weight < q.limit {
			uf.Union(0, edges[edgeIndex].to)
			edgeIndex++
		}
		result[q.index] = uf.Connected(q.src, q.dst)
	}

	return result
}

type UnionFind struct {
	parent []int
}

func NewUnionFind(size int) *UnionFind {
	uf := &UnionFind{parent: make([]int, size)}
	for i := range uf.parent {
		uf.parent[i] = i
	}
	return uf
}

func (uf *UnionFind) Find(x int) int {
	if uf.parent[x] != x {
		uf.parent[x] = uf.Find(uf.parent[x])
	}
	return uf.parent[x]
}

func (uf *UnionFind) Union(x, y int) {
	rootX := uf.Find(x)
	rootY := uf.Find(y)
	if rootX != rootY {
		uf.parent[rootY] = rootX
	}
}

func (uf *UnionFind) Connected(x, y int) bool {
	return uf.Find(x) == uf.Find(y)
}