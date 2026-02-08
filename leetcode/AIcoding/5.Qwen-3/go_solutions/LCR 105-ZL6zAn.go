package main

func maxAreaOfIsland(grid [][]int) int {
	if len(grid) == 0 || len(grid[0]) == 0 {
		return 0
	}

	maxArea := 0
	rows, cols := len(grid), len(grid[0])

	var dfs func(i, j int) int
	dfs = func(i, j int) int {
		if i < 0 || i >= rows || j < 0 || j >= cols || grid[i][j] == 0 {
			return 0
		}
		grid[i][j] = 0 // mark as visited
		area := 1
		area += dfs(i+1, j)
		area += dfs(i-1, j)
		area += dfs(i, j+1)
		area += dfs(i, j-1)
		return area
	}

	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			if grid[i][j] == 1 {
				currentArea := dfs(i, j)
				if currentArea > maxArea {
					maxArea = currentArea
				}
			}
		}
	}

	return maxArea
}