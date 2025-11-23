func latestDayToCross(row int, col int, cells [][]int) int {
	left, right := 0, len(cells)-1
	ans := 0
	for left <= right {
		mid := left + (right-left)/2
		if canCross(row, col, cells, mid) {
			ans = mid
			left = mid + 1
		} else {
			right = mid - 1
		}
	}
	return ans
}

func canCross(row int, col int, cells [][]int, day int) bool {
	grid := make([][]int, row)
	for i := range grid {
		grid[i] = make([]int, col)
	}
	for i := 0; i <= day; i++ {
		grid[cells[i][0]-1][cells[i][1]-1] = 1
	}

	visited := make([][]bool, row)
	for i := range visited {
		visited[i] = make([]bool, col)
	}

	q := make([][]int, 0)
	for j := 0; j < col; j++ {
		if grid[0][j] == 0 {
			q = append(q, []int{0, j})
			visited[0][j] = true
		}
	}

	dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]

		if curr[0] == row-1 {
			return true
		}

		for _, dir := range dirs {
			newRow := curr[0] + dir[0]
			newCol := curr[1] + dir[1]

			if newRow >= 0 && newRow < row && newCol >= 0 && newCol < col && grid[newRow][newCol] == 0 && !visited[newRow][newCol] {
				q = append(q, []int{newRow, newCol})
				visited[newRow][newCol] = true
			}
		}
	}
	return false
}