func isMagicSquare(grid [][]int, i, j int) bool {
	if i+2 >= len(grid) || j+2 >= len(grid) {
		return false
	}

	nums := make(map[int]bool)
	for row := i; row <= i+2; row++ {
		for col := j; col <= j+2; col++ {
			num := grid[row][col]
			if num < 1 || num > 9 || nums[num] {
				return false
			}
			nums[num] = true
		}
	}

	sum := grid[i][j] + grid[i][j+1] + grid[i][j+2]
	if sum != grid[i+1][j]+grid[i+1][j+1]+grid[i+1][j+2] ||
		sum != grid[i+2][j]+grid[i+2][j+1]+grid[i+2][j+2] ||
		sum != grid[i][j]+grid[i+1][j]+grid[i+2][j] ||
		sum != grid[i][j+1]+grid[i+1][j+1]+grid[i+2][j+1] ||
		sum != grid[i][j+2]+grid[i+1][j+2]+grid[i+2][j+2] ||
		sum != grid[i][j]+grid[i+1][j+1]+grid[i+2][j+2] ||
		sum != grid[i][j+2]+grid[i+1][j+1]+grid[i+2][j] {
		return false
	}

	return true
}

func numMagicSquaresInside(grid [][]int) int {
	count := 0
	for i := 0; i < len(grid); i++ {
		for j := 0; j < len(grid[0]); j++ {
			if isMagicSquare(grid, i, j) {
				count++
			}
		}
	}
	return count
}