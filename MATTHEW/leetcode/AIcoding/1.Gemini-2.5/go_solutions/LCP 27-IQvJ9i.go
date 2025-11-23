package main

func findExitPoints(grid [][]string) [][]int {
	m := len(grid)
	n := len(grid[0])

	byteGrid := make([][]byte, m)
	for i := 0; i < m; i++ {
		byteGrid[i] = []byte(grid[i])
	}

	// Directions: 0: Right, 1: Down, 2: Left, 3: Up
	dr := []int{0, 1, 0, -1}
	dc := []int{1, 0, -1, 0}

	// dp[r][c][dir] stores the [exitR, exitC] for a ray starting at (r,c) with direction dir.
	// Initialize with [-2, -2] to indicate not computed.
	dp := make([][][2]int, m)
	for i := 0; i < m; i++ {
		dp[i] = make([][2]int, n)
		for j := 0; j < n; j++ {
			dp[i][j] = make([2]int, 4)
			for k := 0; k < 4; k++ {
				dp[i][j][k] = [2]int{-2, -2}
			}
		}
	}

	// getNextDir calculates the new direction after hitting a mirror.
	// currentDir: 0:R, 1:D, 2:L, 3:U
	// Mirror '/':
	// R (0) -> U (3)
	// D (1) -> L (2)
	// L (2) -> D (1)
	// U (3) -> R (0)
	// Mirror '\':
	// R (0) -> D (1)
	// D (1) -> R (0)
	// L (2) -> U (3)
	// U (3) -> L (2)
	getNextDir := func(currentDir int, mirror byte) int {
		if mirror == '/' {
			switch currentDir {
			case 0:
				return 3
			case 1:
				return 2
			case 2:
				return 1
			case 3:
				return 0
			}
		} else if mirror == '\\' {
			switch currentDir {
			case 0:
				return 1
			case 1:
				return 0
			case 2:
				return 3
			case 3:
				return 2
			}
		}
		return currentDir // '.' case, direction doesn't change
	}

	// trace function uses memoization to find the exit point for a ray.
	var trace func(r, c, dir int) [2]int
	trace = func(r, c, dir int) [2]int {
		// If outside the grid, this is an exit point.
		if r < 0 || r >= m || c < 0 || c >= n {
			return [2]int{r, c}
		}

		// If already computed, return the stored result.
		if dp[r][c][dir][0] != -2 {
			return dp[r][c][dir]
		}

		// Calculate next direction based on the mirror.
		nextDir := getNextDir(dir, byteGrid[r][c])

		// Calculate next position.
		nextR := r + dr[nextDir]
		nextC := c + dc[nextDir]

		// Recursively trace the path.
		result := trace(nextR, nextC, nextDir)

		// Store the result in DP table before returning.
		dp[r][c][dir] = result
		return result
	}

	ans := make([][]int, m)
	for i := 0; i < m; i++ {
		ans[i] = make([]int, n)
	}

	// Simulate rays entering from all border cells.
	// 1. Top border (entering from top, moving down)
	for c := 0; c < n; c++ {
		exit := trace(0, c, 1) // dir 1 is Down
		exitR, exitC := exit[0], exit[1]
		actualExitR, actualExitC := -1, -1

		if exitR < 0 { // Exited from top border
			actualExitR = 0
			actualExitC = exitC
		} else if exitR >= m { // Exited from bottom border
			actualExitR = m - 1
			actualExitC = exitC
		} else if exitC < 0 { // Exited from left border
			actualExitR = exitR
			actualExitC = 0
		} else if exitC >= n { // Exited from right border
			actualExitR = exitR
			actualExitC = n - 1
		}
		if actualExitR != -1 {
			ans[actualExitR][actualExitC]++
		}
	}

	// 2. Bottom border (entering from bottom, moving up)
	for c := 0; c < n; c++ {
		exit := trace(m-1, c, 3) // dir 3 is Up
		exitR, exitC := exit[0], exit[1]
		actualExitR, actualExitC := -1, -1
		if exitR < 0 {
			actualExitR = 0
			actualExitC = exitC
		} else if exitR >= m {
			actualExitR = m - 1
			actualExitC = exitC
		} else if exitC < 0 {
			actualExitR = exitR
			actualExitC = 0
		} else if exitC >= n {
			actualExitR = exitR
			actualExitC = n - 1
		}
		if actualExitR != -1 {
			ans[actualExitR][actualExitC]++
		}
	}

	// 3. Left border (entering from left, moving right)
	for r := 0; r < m; r++ {
		exit := trace(r, 0, 0) // dir 0 is Right
		exitR, exitC := exit[0], exit[1]
		actualExitR, actualExitC := -1, -1
		if exitR < 0 {
			actualExitR = 0
			actualExitC = exitC
		} else if exitR >= m {
			actualExitR = m - 1
			actualExitC = exitC
		} else if exitC < 0 {
			actualExitR = exitR
			actualExitC = 0
		} else if exitC >= n {
			actualExitR = exitR
			actualExitC = n - 1
		}
		if actualExitR != -1 {
			ans[actualExitR][actualExitC]++
		}
	}

	// 4. Right border (entering from right, moving left)
	for r := 0; r < m; r++ {
		exit := trace(r, n-1, 2) // dir 2 is Left
		exitR, exitC := exit[0], exit[1]
		actualExitR, actualExitC := -1, -1
		if exitR < 0 {
			actualExitR = 0
			actualExitC = exitC
		} else if exitR >= m {
			actualExitR = m - 1
			actualExitC = exitC
		} else if exitC < 0 {
			actualExitR = exitR
			actualExitC = 0
		} else if exitC >= n {
			actualExitR = exitR
			actualExitC = n - 1
		}
		if actualExitR != -1 {
			ans[actualExitR][actualExitC]++
		}
	}

	return ans
}