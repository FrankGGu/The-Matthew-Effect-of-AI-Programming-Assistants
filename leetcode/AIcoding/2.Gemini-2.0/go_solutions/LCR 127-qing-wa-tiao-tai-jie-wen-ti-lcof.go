func minimumEffort(heights [][]int) int {
	n := len(heights)
	m := len(heights[0])

	abs := func(x int) int {
		if x < 0 {
			return -x
		}
		return x
	}

	check := func(maxEffort int) bool {
		visited := make([][]bool, n)
		for i := range visited {
			visited[i] = make([]bool, m)
		}

		var dfs func(int, int) bool
		dfs = func(row, col int) bool {
			if row == n-1 && col == m-1 {
				return true
			}

			visited[row][col] = true

			directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
			for _, dir := range directions {
				newRow := row + dir[0]
				newCol := col + dir[1]

				if newRow >= 0 && newRow < n && newCol >= 0 && newCol < m && !visited[newRow][newCol] && abs(heights[row][col]-heights[newRow][newCol]) <= maxEffort {
					if dfs(newRow, newCol) {
						return true
					}
				}
			}

			return false
		}

		return dfs(0, 0)
	}

	left, right := 0, 1000000
	ans := 0
	for left <= right {
		mid := left + (right-left)/2
		if check(mid) {
			ans = mid
			right = mid - 1
		} else {
			left = mid + 1
		}
	}

	return ans
}