func islandPerimeter(grid [][]int) int {
	rows := len(grid)
	cols := len(grid[0])

	perimeter := 0

	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			if grid[r][c] == 1 {
				perimeter += 4

				if r > 0 && grid[r-1][c] == 1 {
					perimeter -= 1
				}
				if r < rows-1 && grid[r+1][c] == 1 {
					perimeter -= 1
				}
				if c > 0 && grid[r][c-1] == 1 {
					perimeter -= 1
				}
				if c < cols-1 && grid[r][c+1] == 1 {
					perimeter -= 1
				}
			}
		}
	}

	return perimeter
}