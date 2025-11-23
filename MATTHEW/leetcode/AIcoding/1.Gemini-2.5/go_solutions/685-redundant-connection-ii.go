package main

type DSU struct {
	parent []int
}

func newDSU(n int) *DSU {
	p := make([]int, n+1)
	for i := 1; i <= n; i++ {
		p[i] = i
	}
	return &DSU{parent: p}
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

func findRedundantDirectedConnection(edges [][]int) []int {
	n := len(edges)

	parentOf := make([]int, n+1)

	var candA, candB []int

	for _, edge := range edges {
		u, v := edge[0], edge[1]
		if parentOf[v] != 0 {
			candA = []int{parentOf[v], v}
			candB = edge
			break
		}
		parentOf[v] = u
	}

	dsu := newDSU(n)

	if candA != nil {
		for _, edge := range edges {
			if edge[0] == candB[0] && edge[1] == candB[1] {
				continue
			}

			u, v := edge[0], edge[1]
			if !dsu.union(u, v) {
				return candA
			}
		}
		return candB
	}

	for _, edge := range edges {
		u, v := edge[0], edge[1]
		if !dsu.union(u, v) {
			return edge
		}
	}

	return nil
}