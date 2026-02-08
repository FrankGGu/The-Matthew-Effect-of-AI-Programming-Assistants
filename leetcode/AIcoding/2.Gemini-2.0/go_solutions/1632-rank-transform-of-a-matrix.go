func matrixRankTransform(matrix [][]int) [][]int {
	m, n := len(matrix), len(matrix[0])
	rank := make([]int, m+n)
	for i := range rank {
		rank[i] = 1
	}
	result := make([][]int, m)
	for i := range result {
		result[i] = make([]int, n)
	}

	type cell struct {
		row, col int
	}

	type edge struct {
		u, v int
	}

	for val := -500; val <= 500; val++ {
		cells := []cell{}
		for i := 0; i < m; i++ {
			for j := 0; j < n; j++ {
				if matrix[i][j] == val {
					cells = append(cells, cell{i, j})
				}
			}
		}

		if len(cells) == 0 {
			continue
		}

		parent := make([]int, m+n)
		for i := range parent {
			parent[i] = i
		}

		find := func(x int) int {
			if parent[x] != x {
				parent[x] = find(parent[x])
			}
			return parent[x]
		}

		union := func(x, y int) {
			xRoot := find(x)
			yRoot := find(y)
			if xRoot != yRoot {
				parent[xRoot] = yRoot
			}
		}

		for _, c := range cells {
			union(c.row, c.col+m)
		}

		groupRank := make(map[int]int)
		for _, c := range cells {
			root := find(c.row)
			groupRank[root] = max(groupRank[root], rank[c.row], rank[c.col+m])
		}

		for _, c := range cells {
			root := find(c.row)
			result[c.row][c.col] = groupRank[root]
		}

		for _, c := range cells {
			rank[c.row] = result[c.row][c.col] + 1
			rank[c.col+m] = result[c.row][c.col] + 1
		}
	}

	return result
}

func max(nums ...int) int {
	res := nums[0]
	for _, num := range nums {
		if num > res {
			res = num
		}
	}
	return res
}