func regionsBySlashes(grid []string) int {
	n := len(grid)
	uf := newUnionFind(3 * n * n)
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			idx := i*n + j
			if grid[i][j] == '/' {
				uf.union(idx*3+0, idx*3+1)
				uf.union(idx*3+2, idx*3+3)
			} else if grid[i][j] == '\\' {
				uf.union(idx*3+0, idx*3+3)
				uf.union(idx*3+1, idx*3+2)
			} else {
				uf.union(idx*3+0, idx*3+1)
				uf.union(idx*3+1, idx*3+2)
				uf.union(idx*3+2, idx*3+3)
			}

			if i > 0 {
				uf.union(idx*3+0, ((i-1)*n+j)*3+2)
			}
			if i < n-1 {
				uf.union(idx*3+2, ((i+1)*n+j)*3+0)
			}
			if j > 0 {
				uf.union(idx*3+3, (i*n+j-1)*3+1)
			}
			if j < n-1 {
				uf.union(idx*3+1, (i*n+j+1)*3+3)
			}
		}
	}

	count := 0
	for i := 0; i < 3*n*n; i++ {
		if uf.find(i) == i {
			count++
		}
	}
	return count
}

type unionFind struct {
	parent []int
}

func newUnionFind(n int) *unionFind {
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
	}
	return &unionFind{parent: parent}
}

func (uf *unionFind) find(x int) int {
	if uf.parent[x] != x {
		uf.parent[x] = uf.find(uf.parent[x])
	}
	return uf.parent[x]
}

func (uf *unionFind) union(x, y int) {
	rootX := uf.find(x)
	rootY := uf.find(y)
	if rootX != rootY {
		uf.parent[rootX] = rootY
	}
}