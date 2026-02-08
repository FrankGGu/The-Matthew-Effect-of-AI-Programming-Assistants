func checkValidGrid(grid [][]int) bool {
	if grid[0][0] != 0 {
		return false
	}
	n := len(grid)
	pos := make([][]int, n*n)
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			pos[grid[i][j]] = []int{i, j}
		}
	}
	for i := 1; i < n*n; i++ {
		x1, y1 := pos[i-1][0], pos[i-1][1]
		x2, y2 := pos[i][0], pos[i][1]
		if abs(x1-x2) + abs(y1-y2) != 1 && abs(x1-x2) + abs(y1-y2) != 3 {
			return false
		}
		if abs(x1-x2) == 0 && abs(y1-y2) == 0 {
            return false
        }
		if abs(x1-x2) == abs(y1-y2) {
            return false
        }

		if abs(x1 - x2) != 1 && abs(y1-y2) != 2 && abs(x1 - x2) != 2 && abs(y1 - y2) != 1 {
            return false
        }

		if abs(x1 - x2) + abs(y1 - y2) != 3 {
			return false
		}
	}
	return true
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}