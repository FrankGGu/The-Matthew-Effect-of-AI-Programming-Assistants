import "sort"

func deleteGreatestValue(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])
	ans := 0

	for i := 0; i < m; i++ {
		sort.Ints(grid[i])
	}

	for j := 0; j < n; j++ {
		maxVal := 0
		for i := 0; i < m; i++ {
			if grid[i][j] > maxVal {
				maxVal = grid[i][j]
			}
		}
		ans += maxVal
	}

	return ans
}