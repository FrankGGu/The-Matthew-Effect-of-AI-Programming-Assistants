func minDays(grid [][]int) int {
	n := len(grid)
	m := len(grid[0])

	var countIslands func([][]int) int
	countIslands = func(grid [][]int) int {
		visited := make([][]bool, n)
		for i := range visited {
			visited[i] = make([]bool, m)
		}
		count := 0
		var dfs func(int, int)
		dfs = func(i int, j int) {
			if i < 0 || i >= n || j < 0 || j >= m || grid[i][j] == 0 || visited[i][j] {
				return
			}
			visited[i][j] = true
			dfs(i+1, j)
			dfs(i-1, j)
			dfs(i, j+1)
			dfs(i, j-1)
		}

		for i := 0; i < n; i++ {
			for j := 0; j < m; j++ {
				if grid[i][j] == 1 && !visited[i][j] {
					dfs(i, j)
					count++
				}
			}
		}
		return count
	}

	initialIslands := countIslands(grid)

	if initialIslands == 0 || initialIslands > 1 {
		return 0
	}

	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			if grid[i][j] == 1 {
				temp := grid[i][j]
				grid[i][j] = 0
				if countIslands(grid) != 1 {
					return 1
				}
				grid[i][j] = temp
			}
		}
	}

	return 2
}