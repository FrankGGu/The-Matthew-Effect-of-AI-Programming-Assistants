package main

func fillSpecialGrid(m int, n int) [][]int {
	grid := make([][]int, m)
	for i := range grid {
		grid[i] = make([]int, n)
	}

	top, bottom := 0, m-1
	left, right := 0, n-1
	currentNum := 1

	for currentNum <= m*n {
		for j := left; j <= right; j++ {
			grid[top][j] = currentNum
			currentNum++
		}
		top++
		if top > bottom {
			break
		}

		for i := top; i <= bottom; i++ {
			grid[i][right] = currentNum
			currentNum++
		}
		right--
		if left > right {
			break
		}

		for j := right; j >= left; j-- {
			grid[bottom][j] = currentNum
			currentNum++
		}
		bottom--
		if top > bottom {
			break
		}

		for i := bottom; i >= top; i-- {
			grid[i][left] = currentNum
			currentNum++
		}
		left++
		if left > right {
			break
		}
	}

	return grid
}