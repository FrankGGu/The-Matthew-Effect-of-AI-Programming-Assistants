package main

type DSU struct {
	parent []int
}

func newDSU(n int) *DSU {
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
	}
	return &DSU{parent: parent}
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
		d.parent[rootI] = rootJ
		return true
	}
	return false
}

func makeConnected(n int, connections [][]int) int {
	if len(connections) < n-1 {
		return -1
	}

	dsu := newDSU(n)
	for _, conn := range connections {
		dsu.union(conn[0], conn[1])
	}

	numComponents := 0
	for i := 0; i < n; i++ {
		if dsu.parent[i] == i {
			numComponents++
		}
	}

	return numComponents - 1
}