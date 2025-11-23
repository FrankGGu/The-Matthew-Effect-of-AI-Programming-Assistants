func canMouseWin(grid []string, catJump int, mouseJump int) bool {
	rows, cols := len(grid), len(grid[0])
	foodRow, foodCol := -1, -1
	mouseStartRow, mouseStartCol := -1, -1
	catStartRow, catStartCol := -1, -1

	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			if grid[i][j] == 'F' {
				foodRow, foodCol = i, j
			} else if grid[i][j] == 'M' {
				mouseStartRow, mouseStartCol = i, j
			} else if grid[i][j] == 'C' {
				catStartRow, catStartCol = i, j
			}
		}
	}

	memo := make([][][][][]int, rows)
	for i := range memo {
		memo[i] = make([][][][]int, cols)
		for j := range memo[i] {
			memo[i][j] = make([][][]int, rows)
			for k := range memo[i][j] {
				memo[i][j][k] = make([][]int, cols)
				for l := range memo[i][j][k] {
					memo[i][j][k][l] = make([]int, 101)
					for m := range memo[i][j][k][l] {
						memo[i][j][k][l][m] = -1
					}
				}
			}
		}
	}

	var solve func(mouseRow, mouseCol, catRow, catCol, moves int) bool
	solve = func(mouseRow, mouseCol, catRow, catCol, moves int) bool {
		if moves >= 100 {
			return false
		}

		if memo[mouseRow][mouseCol][catRow][catCol][moves] != -1 {
			return memo[mouseRow][mouseCol][catRow][catCol][moves] == 1
		}

		if mouseRow == catRow && mouseCol == catCol {
			memo[mouseRow][mouseCol][catRow][catCol][moves] = 0
			return false
		}

		if mouseRow == foodRow && mouseCol == foodCol {
			memo[mouseRow][mouseCol][catRow][catCol][moves] = 1
			return true
		}

		if catRow == foodRow && catCol == foodCol {
			memo[mouseRow][mouseCol][catRow][catCol][moves] = 0
			return false
		}

		if moves%2 == 0 { // Mouse's turn
			canWin := false
			directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}, {0, 0}}
			for _, dir := range directions {
				for jump := 0; jump <= mouseJump; jump++ {
					newMouseRow, newMouseCol := mouseRow+jump*dir[0], mouseCol+jump*dir[1]
					if newMouseRow < 0 || newMouseRow >= rows || newMouseCol < 0 || newMouseCol >= cols || grid[newMouseRow][newMouseCol] == '#' {
						break
					}
					if !solve(newMouseRow, newMouseCol, catRow, catCol, moves+1) {
						canWin = true
						break
					}
				}
				if canWin {
					break
				}
			}
			if canWin {
				memo[mouseRow][mouseCol][catRow][catCol][moves] = 1
				return true
			} else {
				memo[mouseRow][mouseCol][catRow][catCol][moves] = 0
				return false
			}
		} else { // Cat's turn
			canWin := true
			directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}, {0, 0}}
			for _, dir := range directions {
				for jump := 0; jump <= catJump; jump++ {
					newCatRow, newCatCol := catRow+jump*dir[0], catCol+jump*dir[1]
					if newCatRow < 0 || newCatRow >= rows || newCatCol < 0 || newCatCol >= cols || grid[newCatRow][newCatCol] == '#' {
						break
					}
					if !solve(mouseRow, mouseCol, newCatRow, newCatCol, moves+1) {
						canWin = false
						break
					}
				}
				if !canWin {
					break
				}
			}

			if canWin {
				memo[mouseRow][mouseCol][catRow][catCol][moves] = 0
				return false
			} else {
				memo[mouseRow][mouseCol][catRow][catCol][moves] = 1
				return true
			}
		}
	}

	return solve(mouseStartRow, mouseStartCol, catStartRow, catStartCol, 0)
}