func maxTrailingZeros(grid [][]int) int {
	m, n := len(grid), len(grid[0])
	rowTwo := make([][]int, m)
	rowFive := make([][]int, m)
	colTwo := make([][]int, n)
	colFive := make([][]int, n)

	for i := 0; i < m; i++ {
		rowTwo[i] = make([]int, n)
		rowFive[i] = make([]int, n)
	}
	for j := 0; j < n; j++ {
		colTwo[j] = make([]int, m)
		colFive[j] = make([]int, m)
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			val := grid[i][j]
			for val > 0 && val%2 == 0 {
				rowTwo[i][j]++
				val /= 2
			}
			val = grid[i][j]
			for val > 0 && val%5 == 0 {
				rowFive[i][j]++
				val /= 5
			}
		}
	}

	for j := 0; j < n; j++ {
		for i := 0; i < m; i++ {
			val := grid[i][j]
			for val > 0 && val%2 == 0 {
				colTwo[j][i]++
				val /= 2
			}
			val = grid[i][j]
			for val > 0 && val%5 == 0 {
				colFive[j][i]++
				val /= 5
			}
		}
	}

	maxZeros := 0
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			two := rowTwo[i][j] + colTwo[j][i] - countFactors(grid[i][j], 2)
			five := rowFive[i][j] + colFive[j][i] - countFactors(grid[i][j], 5)
			maxZeros = max(maxZeros, min(two, five))

			two = rowTwo[i][0] + colTwo[j][i] - countFactors(grid[i][j], 2)
			five = rowFive[i][0] + colFive[j][i] - countFactors(grid[i][j], 5)
			if j != 0 {
				two += rowTwo[i][j] - rowTwo[i][0]
				five += rowFive[i][j] - rowFive[i][0]
			}

			maxZeros = max(maxZeros, min(two, five))

			two = rowTwo[i][n-1] + colTwo[j][i] - countFactors(grid[i][j], 2)
			five = rowFive[i][n-1] + colFive[j][i] - countFactors(grid[i][j], 5)
			if j != n-1 {
				two += rowTwo[i][j] - rowTwo[i][n-1]
				five += rowFive[i][j] - rowFive[i][n-1]
			}

			maxZeros = max(maxZeros, min(two, five))

			two = colTwo[0][i] + rowTwo[i][j] - countFactors(grid[i][j], 2)
			five = colFive[0][i] + rowFive[i][j] - countFactors(grid[i][j], 5)
			if i != 0 {
				two += colTwo[j][i] - colTwo[j][0]
				five += colFive[j][i] - colFive[j][0]
			}
			maxZeros = max(maxZeros, min(two, five))

			two = colTwo[n-1][i] + rowTwo[i][j] - countFactors(grid[i][j], 2)
			five = colFive[n-1][i] + rowFive[i][j] - countFactors(grid[i][j], 5)
			if i != m-1 {
				two += colTwo[j][i] - colTwo[j][m-1]
				five += colFive[j][i] - colFive[j][m-1]
			}
			maxZeros = max(maxZeros, min(two, five))
		}
	}

	return maxZeros
}

func countFactors(num int, factor int) int {
	count := 0
	for num > 0 && num%factor == 0 {
		count++
		num /= factor
	}
	return count
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}