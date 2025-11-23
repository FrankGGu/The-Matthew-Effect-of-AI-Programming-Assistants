func pacificAtlantic(heights [][]int) [][]int {
	m := len(heights)
	n := len(heights[0])

	pacificReachable := make([][]bool, m)
	atlanticReachable := make([][]bool, m)
	for i := range pacificReachable {
		pacificReachable[i] = make([]bool, n)
		atlanticReachable[i] = make([]bool, n)
	}

	var dfs func(row, col int, reachable [][]bool)
	dfs = func(row, col int, reachable [][]bool) {
		if reachable[row][col] {
			return
		}
		reachable[row][col] = true

		directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
		for _, dir := range directions {
			newRow := row + dir[0]
			newCol := col + dir[1]

			if newRow >= 0 && newRow < m && newCol >= 0 && newCol < n &&
				heights[newRow][newCol] >= heights[row][col] {
				dfs(newRow, newCol, reachable)
			}
		}
	}

	for i := 0; i < m; i++ {
		dfs(i, 0, pacificReachable)
		dfs(i, n-1, atlanticReachable)
	}

	for j := 0; j < n; j++ {
		dfs(0, j, pacificReachable)
		dfs(m-1, j, atlanticReachable)
	}

	result := [][]int{}
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if pacificReachable[i][j] && atlanticReachable[i][j] {
				result = append(result, []int{i, j})
			}
		}
	}

	return result
}