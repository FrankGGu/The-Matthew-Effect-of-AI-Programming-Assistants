package main

import "sort"

type DSU struct {
	parent []int
	count  int
}

func newDSU(n int) *DSU {
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
	}
	return &DSU{parent: parent, count: n}
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
		d.parent[rootJ] = rootI
		d.count--
		return true
	}
	return false
}

type Edge struct {
	u, v, cost int
}

type ByCost []Edge

func (a ByCost) Len() int           { return len(a) }
func (a ByCost) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }
func (a ByCost) Less(i, j int) bool { return a[i].cost < a[j].cost }

func minTravelTime(n int, merges [][]int) int {
	if n <= 1 {
		return 0
	}

	edges := make([]Edge, len(merges))
	for i, merge := range merges {
		edges[i] = Edge{u: merge[0], v: merge[1], cost: merge[2]}
	}

	sort.Sort(ByCost(edges))

	dsu := newDSU(n)
	totalCost := 0

	for _, edge := range edges {
		if dsu.union(edge.u, edge.v) {
			totalCost += edge.cost
			if dsu.count == 1 {
				return totalCost
			}
		}
	}

	if dsu.count > 1 {
		return -1
	}

	return totalCost
}