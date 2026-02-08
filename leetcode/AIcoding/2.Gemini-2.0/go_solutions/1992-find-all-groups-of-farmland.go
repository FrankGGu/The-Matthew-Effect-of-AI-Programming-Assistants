func findFarmland(land [][]int) [][]int {
	m := len(land)
	n := len(land[0])
	res := [][]int{}

	var dfs func(i, j int) (int, int)
	dfs = func(i, j int) (int, int) {
		if i >= m || j >= n || land[i][j] == 0 {
			return i - 1, j - 1
		}
		land[i][j] = 0
		x1, y1 := dfs(i+1, j)
		x2, y2 := dfs(i, j+1)

		x := x1
		if x2 > x1 {
			x = x2
		}
		y := y1
		if y2 > y1 {
			y = y2
		}

		return x, y
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if land[i][j] == 1 {
				x, y := dfs(i, j)
				res = append(res, []int{i, j, x, y})
			}
		}
	}

	return res
}