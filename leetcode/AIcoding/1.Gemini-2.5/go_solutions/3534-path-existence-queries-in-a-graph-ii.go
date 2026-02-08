package main

import (
	"sort"
)

type DSU struct {
	parent []int
	rank   []int
}

func newDSU(n int) *DSU {
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
	}
	return &DSU{
		parent: parent,
		rank:   make([]int, n),
	}
}

func (d *DSU) find(i int) int {
	if d.parent[i] == i {
		return i
	}
	d.parent[i] = d.find(d.parent[i])
	return d.parent[i]
}

func (d *DSU) union(i, j int) bool {
	rootI := d.find(i)
	rootJ := d.find(j)

	if rootI != rootJ {
		if d.rank[rootI] < d.rank[rootJ] {
			d.parent[rootI] = rootJ
		} else if d.rank[rootI] > d.rank[rootJ] {
			d.parent[rootJ] = rootI
		} else {
			d.parent[rootJ] = rootI
			d.rank[rootI]++
		}
		return true
	}
	return false
}

type Edge struct {
	u, v, weight int
}

type Query struct {
	u, v, limit int
	index       int
}

func distanceLimitedPathsExist(n int, edgeList [][]int, queries [][]int) []bool {
	edges := make([]Edge, len(edgeList))
	for i, e := range edgeList {
		edges[i] = Edge{u: e[0], v: e[1], weight: e[2]}
	}

	sort.Slice(edges, func(i, j int) bool {
		return edges[i].weight < edges[j].weight
	})

	queryStructs := make([]Query, len(queries))
	for i, q := range queries {
		queryStructs[i] = Query{u: q[0], v: q[1], limit: q[2], index: i}
	}

	sort.Slice(queryStructs, func(i, j int) bool {
		return queryStructs[i].limit < queryStructs[j].limit
	})

	results := make([]bool, len(queries))
	dsu := newDSU(n)
	edgeIdx := 0

	for _, q := range queryStructs {
		for edgeIdx < len(edges) && edges[edgeIdx].weight < q.limit {
			dsu.union(edges[edgeIdx].u, edges[edgeIdx].v)
			edgeIdx++
		}
		results[q.index] = dsu.find(q.u) == dsu.find(q.v)
	}

	return results
}