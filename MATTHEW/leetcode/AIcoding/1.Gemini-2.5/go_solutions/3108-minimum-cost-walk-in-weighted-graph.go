package main

type DSU struct {
	parent []int
	minAnd []int
}

func newDSU(n int) *DSU {
	parent := make([]int, n)
	minAnd := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
		minAnd[i] = (1 << 31) - 1 // Initialize with all bits set (identity for bitwise AND)
	}
	return &DSU{parent: parent, minAnd: minAnd}
}

func (d *DSU) find(i int) int {
	if d.parent[i] == i {
		return i
	}
	d.parent[i] = d.find(d.parent[i])
	return d.parent[i]
}

func (d *DSU) union(x, y, weight int) {
	rootX := d.find(x)
	rootY := d.find(y)

	if rootX != rootY {
		d.minAnd[rootX] = d.minAnd[rootX] & d.minAnd[rootY] & weight
		d.parent[rootY] = rootX
	} else {
		d.minAnd[rootX] = d.minAnd[rootX] & weight
	}
}

func minimumCost(n int, edges [][]int, query [][]int) []int {
	dsu := newDSU(n)

	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		dsu.union(u, v, w)
	}

	results := make([]int, len(query))
	for i, q := range query {
		s, t := q[0], q[1]
		if s == t {
			results[i] = 0
			continue
		}

		rootS := dsu.find(s)
		rootT := dsu.find(t)

		if rootS == rootT {
			results[i] = dsu.minAnd[rootS]
		} else {
			results[i] = -1
		}
	}

	return results
}