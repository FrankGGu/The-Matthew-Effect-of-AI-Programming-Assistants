func minimumOperationsToWriteY(grid [][]int) int {
	n := len(grid)
	ones := make([]int, 2)
	zeros := make([]int, 2)
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if (i == j || i+j == n-1) && i <= n/2 {
				if grid[i][j] == 1 {
					ones[0]++
				} else {
					zeros[0]++
				}
			} else {
				if grid[i][j] == 1 {
					ones[1]++
				} else {
					zeros[1]++
				}
			}
		}
	}

	ans := 1 << 30
	for i := 0; i < 2; i++ {
		for j := 0; j < 2; j++ {
			if i != j {
				cur := 0
				if i == 0 {
					cur += ones[0]
				} else {
					cur += zeros[0]
				}
				if j == 0 {
					cur += ones[1]
				} else {
					cur += zeros[1]
				}
				ans = min(ans, cur)
			}
		}
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}