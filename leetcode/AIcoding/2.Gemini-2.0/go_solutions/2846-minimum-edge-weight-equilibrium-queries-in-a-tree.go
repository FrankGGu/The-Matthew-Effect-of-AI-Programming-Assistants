type dsu struct {
	parent []int
	size   []int
}

func newDSU(n int) *dsu {
	parent := make([]int, n)
	size := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
		size[i] = 1
	}
	return &dsu{parent: parent, size: size}
}

func (d *dsu) find(x int) int {
	if d.parent[x] != x {
		d.parent[x] = d.find(d.parent[x])
	}
	return d.parent[x]
}

func (d *dsu) union(x, y int) {
	rootX := d.find(x)
	rootY := d.find(y)
	if rootX != rootY {
		if d.size[rootX] < d.size[rootY] {
			rootX, rootY = rootY, rootX
		}
		d.parent[rootY] = rootX
		d.size[rootX] += d.size[rootY]
	}
}

func minCost(n int, edges [][]int, queries [][]int) []int {
	ans := make([]int, len(queries))
	for i := range ans {
		ans[i] = -1
	}

	for weight := 1; weight <= 26; weight++ {
		dsu := newDSU(n)
		for _, edge := range edges {
			if edge[2] == weight {
				dsu.union(edge[0], edge[1])
			}
		}

		for i, query := range queries {
			if dsu.find(query[0]) == dsu.find(query[1]) {
				if ans[i] == -1 {
					ans[i] = weight
				} else {
					ans[i] = min(ans[i], weight)
				}
			}
		}
	}

	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}