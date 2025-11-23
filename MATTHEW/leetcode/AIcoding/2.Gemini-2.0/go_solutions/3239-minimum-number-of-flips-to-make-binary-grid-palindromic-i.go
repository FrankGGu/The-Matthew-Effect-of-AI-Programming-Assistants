func minFlips(grid [][]int) int {
	m, n := len(grid), len(grid[0])
	ans := -1

	for mask := 0; mask < (1 << (m * n)); mask++ {
		tempGrid := make([][]int, m)
		for i := range tempGrid {
			tempGrid[i] = make([]int, n)
			copy(tempGrid[i], grid[i])
		}

		flips := 0
		for i := 0; i < m; i++ {
			for j := 0; j < n; j++ {
				bit := i*n + j
				if (mask>>bit)&1 == 1 {
					tempGrid[i][j] = 1 - tempGrid[i][j]
					flips++
				}
			}
		}

		isPalindrome := true
		for i := 0; i < m; i++ {
			for j := 0; j < n/2; j++ {
				if tempGrid[i][j] != tempGrid[i][n-1-j] {
					isPalindrome = false
					break
				}
			}
			if !isPalindrome {
				break
			}
		}

		if isPalindrome {
			if ans == -1 || flips < ans {
				ans = flips
			}
		}
	}

	return ans
}