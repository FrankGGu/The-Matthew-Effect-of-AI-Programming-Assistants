package main

func minOperations(grid [][]int) int {
	rows := len(grid)
	cols := len(grid[0])
	totalOperations := 0

	for j := 0; j < cols; j++ {
		currentColumn := make([]int, rows)
		for i := 0; i < rows; i++ {
			currentColumn[i] = grid[i][j]
		}

		ops := solveColumn(currentColumn, rows)
		if ops == -1 {
			return -1
		}
		totalOperations += ops
	}

	return totalOperations
}

func solveColumn(col []int, m int) int {
	if m == 1 {
		return 0
	}

	seen := make(map[int]bool)
	for _, x := range col {
		if seen[x] {
			return -1
		}
		seen[x] = true
	}

	for k := 0; k < m; k++ {
		isIncreasing := true
		for i := 0; i < m-1; i++ {
			val1 := col[(i - k + m) % m]
			val2 := col[(i + 1 - k + m) % m]
			if val1 >= val2 {
				isIncreasing = false
				break
			}
		}
		if isIncreasing {
			return k
		}
	}

	return -1
}