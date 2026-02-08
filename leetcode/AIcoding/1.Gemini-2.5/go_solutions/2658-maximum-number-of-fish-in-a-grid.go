package main

func findMaxFish(grid [][]int) int {
	rows := len(grid)
	if rows == 0 {
		return 0
	}
	cols := len(grid[0])
	if cols == 0 {
		return 0
	}

	maxFish := 0

	var dfs func(r, c int) int
	dfs = func(r, c int) int {
		if r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0 {
			return 0
		}

		currentFish := grid[r][c]
		grid[r][c] = 0

		currentFish += dfs(r+1, c)
		currentFish += dfs(r-1, c)
		currentFish += dfs(r, c+1)
		currentFish += dfs(r, c-1)

		return currentFish
	}

	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			if grid[r][c] > 0 {
				fishCount := dfs(r, c)
				if fishCount > maxFish {
					maxFish = fishCount
				}
			}
		}
	}

	return maxFish
}