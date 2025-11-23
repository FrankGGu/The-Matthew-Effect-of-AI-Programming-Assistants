package main

type DSU struct {
	parent []int
}

func NewDSU(n int) *DSU {
	parent := make([]int, n+1)
	for i := 0; i <= n; i++ {
		parent[i] = i
	}
	return &DSU{parent: parent}
}

func (d *DSU) Find(i int) int {
	if d.parent[i] == i {
		return i
	}
	d.parent[i] = d.Find(d.parent[i])
	return d.parent[i]
}

func (d *DSU) Union(i, j int) {
	rootI := d.Find(i)
	rootJ := d.Find(j)
	if rootI != rootJ {
		d.parent[rootJ] = rootI
	}
}

func areConnected(n int, threshold int, queries [][]int) []bool {
	dsu := NewDSU(n)

	for g := threshold + 1; g <= n; g++ {
		for i := 2 * g; i <= n; i += g {
			dsu.Union(g, i)
		}
	}

	result := make([]bool, len(queries))
	for k, query := range queries {
		city1, city2 := query[0], query[1]
		if dsu.Find(city1) == dsu.Find(city2) {
			result[k] = true
		} else {
			result[k] = false
		}
	}

	return result
}