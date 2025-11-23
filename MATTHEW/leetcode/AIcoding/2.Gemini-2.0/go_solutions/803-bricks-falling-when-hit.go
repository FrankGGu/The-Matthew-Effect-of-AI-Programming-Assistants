func hitBricks(grid [][]int, hits [][]int) []int {
	m, n := len(grid), len(grid[0])
	ans := make([]int, len(hits))

	// Mark hits as 0
	for _, hit := range hits {
		grid[hit[0]][hit[1]] -= 1
		if grid[hit[0]][hit[1]] < 0 {
			grid[hit[0]][hit[1]] = 0
		}
	}

	// Connect top row bricks
	uf := newUnionFind(m*n + 1)
	for j := 0; j < n; j++ {
		if grid[0][j] == 1 {
			uf.union(j+1, 0)
		}
	}

	// Union adjacent bricks
	for i := 1; i < m; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == 1 {
				if grid[i-1][j] == 1 {
					uf.union(i*n+j+1, (i-1)*n+j+1)
				}
				if j > 0 && grid[i][j-1] == 1 {
					uf.union(i*n+j+1, i*n+j)
				}
			}
		}
	}

	// Process hits in reverse order
	for i := len(hits) - 1; i >= 0; i-- {
		hit := hits[i]
		row, col := hit[0], hit[1]

		if grid[row][col] == 0 {
			grid[row][col] = 0 // Reset for consistency
			continue
		}

		grid[row][col] = 1
		originalSize := uf.size(0)

		// Connect to top if possible
		if row == 0 {
			uf.union(col+1, 0)
		}

		// Connect adjacent bricks
		if row > 0 && grid[row-1][col] == 1 {
			uf.union(row*n+col+1, (row-1)*n+col+1)
		}
		if row < m-1 && grid[row+1][col] == 1 {
			uf.union(row*n+col+1, (row+1)*n+col+1)
		}
		if col > 0 && grid[row][col-1] == 1 {
			uf.union(row*n+col+1, row*n+col)
		}
		if col < n-1 && grid[row][col+1] == 1 {
			uf.union(row*n+col+1, row*n+col+2)
		}

		newSize := uf.size(0)
		ans[i] = max(0, newSize-originalSize-1)
	}

	return ans
}

type unionFind struct {
	parent []int
	size_  []int
}

func newUnionFind(n int) *unionFind {
	parent := make([]int, n)
	size_ := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
		size_[i] = 1
	}
	return &unionFind{parent: parent, size_: size_}
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
		if uf.size_[rootX] < uf.size_[rootY] {
			rootX, rootY = rootY, rootX
		}
		uf.parent[rootY] = rootX
		uf.size_[rootX] += uf.size_[rootY]
	}
}

func (uf *unionFind) size(x int) int {
	return uf.size_[uf.find(x)]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}