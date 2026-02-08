func numMagicSquaresInside(grid [][]int) int {
	m := len(grid)
	if m < 3 {
		return 0
	}
	n := len(grid[0])
	if n < 3 {
		return 0
	}

	count := 0
	for r := 0; r <= m-3; r++ {
		for c := 0; c <= n-3; c++ {
			if isMagicSquare(r, c, grid) {
				count++
			}
		}
	}
	return count
}

func isMagicSquare(r, c int, grid [][]int) bool {
	// Check distinct numbers 1-9
	seen := make([]bool, 10)
	nums := []int{
		grid[r][c], grid[r][c+1], grid[r][c+2],
		grid[r+1][c], grid[r+1][c+1], grid[r+1][c+2],
		grid[r+2][c], grid[r+2][c+1], grid[r+2][c+2],
	}

	for _, num := range nums {
		if num < 1 || num > 9 {
			return false
		}
		if seen[num] {
			return false // Duplicate number
		}
		seen[num] = true
	}

	// All 9 numbers must be distinct and within 1-9.
	// If they pass the above check, they must be {1, 2, 3, 4, 5, 6, 7, 8, 9}.
	// The magic sum for such a square is always 15.

	// Check sums (all must be 15)
	// Rows
	if grid[r][c]+grid[r][c+1]+grid[r][c+2] != 15 {
		return false
	}
	if grid[r+1][c]+grid[r+1][c+1]+grid[r+1][c+2] != 15 {
		return false
	}
	if grid[r+2][c]+grid[r+2][c+1]+grid[r+2][c+2] != 15 {
		return false
	}
	// Columns
	if grid[r][c]+grid[r+1][c]+grid[r+2][c] != 15 {
		return false
	}
	if grid[r][c+1]+grid[r+1][c+1]+grid[r+2][c+1] != 15 {
		return false
	}
	if grid[r][c+2]+grid[r+1][c+2]+grid[r+2][c+2] != 15 {
		return false
	}
	// Diagonals
	if grid[r][c]+grid[r+1][c+1]+grid[r+2][c+2] != 15 {
		return false
	}
	if grid[r][c+2]+grid[r+1][c+1]+grid[r+2][c] != 15 {
		return false
	}

	return true
}