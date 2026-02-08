type DSU struct {
	parent []int
}

func NewDSU(n int) *DSU {
	dsu := &DSU{
		parent: make([]int, n),
	}
	for i := 0; i < n; i++ {
		dsu.parent[i] = i
	}
	return dsu
}

func (dsu *DSU) Find(x int) int {
	if dsu.parent[x] != x {
		dsu.parent[x] = dsu.Find(dsu.parent[x])
	}
	return dsu.parent[x]
}

func (dsu *DSU) Union(x, y int) {
	rootX := dsu.Find(x)
	rootY := dsu.Find(y)
	if rootX != rootY {
		dsu.parent[rootX] = rootY
	}
}

func areConnected(n int, threshold int, queries [][]int) []bool {
	dsu := NewDSU(n + 1)

	for i := threshold + 1; i <= n; i++ {
		for j := 2 * i; j <= n; j += i {
			dsu.Union(i, j)
		}
	}

	result := make([]bool, len(queries))
	for i, query := range queries {
		a := query[0]
		b := query[1]
		result[i] = dsu.Find(a) == dsu.Find(b)
	}

	return result
}