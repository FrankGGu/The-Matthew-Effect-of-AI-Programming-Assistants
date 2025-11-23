package main

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func countFertilePyramids(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	ans := 0

	// dp[r][c] stores the maximum height h of a regular pyramid with apex at (r,c).
	// A pyramid of height h (h >= 1) means it has h+1 rows.
	// If dp[r][c] = k, it means there are k pyramids of height 1 to k with apex (r,c).
	// A value of 0 means only a pyramid of height 0 (just the cell itself) can be formed, or it's not fertile.
	dp := make([][]int, m)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	// Calculate for regular pyramids (apex at r, base at r+h)
	// Iterate from bottom-up for rows
	for r := m - 1; r >= 0; r-- {
		for c := 0; c < n; c++ {
			if grid[r][c] == 0 {
				dp[r][c] = 0
			} else {
				// Boundary conditions: A pyramid of height >= 1 cannot be formed
				// if the apex is on the last row, or first/last column.
				if r == m-1 || c == 0 || c == n-1 {
					dp[r][c] = 0
				} else {
					// A pyramid of height H with apex (r,c) exists if:
					// 1. grid[r][c] == 1
					// 2. A pyramid of height H-1 exists with apex (r+1, c-1)
					// 3. A pyramid of height H-1 exists with apex (r+1, c)
					// 4. A pyramid of height H-1 exists with apex (r+1, c+1)
					// The minimum of these three sub-pyramid heights determines the maximum height for (r,c).
					dp[r][c] = 1 + min(dp[r+1][c-1], min(dp[r+1][c], dp[r+1][c+1]))
				}
			}
			ans += dp[r][c]
		}
	}

	// dp_inv[r][c] stores the maximum height h of an inverse pyramid with apex at (r,c).
	// An inverse pyramid of height h (h >= 1) means it has h+1 rows.
	// A value of 0 means only an inverse pyramid of height 0 (just the cell itself) can be formed, or it's not fertile.
	dp_inv := make([][]int, m)
	for i := range dp_inv {
		dp_inv[i] = make([]int, n)
	}

	// Calculate for inverse pyramids (apex at r, base at r-h)
	// Iterate from top-down for rows
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if grid[r][c] == 0 {
				dp_inv[r][c] = 0
			} else {
				// Boundary conditions: An inverse pyramid of height >= 1 cannot be formed
				// if the apex is on the first row, or first/last column.
				if r == 0 || c == 0 || c == n-1 {
					dp_inv[r][c] = 0
				} else {
					// An inverse pyramid of height H with apex (r,c) exists if:
					// 1. grid[r][c] == 1
					// 2. An inverse pyramid of height H-1 exists with apex (r-1, c-1)
					// 3. An inverse pyramid of height H-1 exists with apex (r-1, c)
					// 4. An inverse pyramid of height H-1 exists with apex (r-1, c+1)
					// The minimum of these three sub-pyramid heights determines the maximum height for (r,c).
					dp_inv[r][c] = 1 + min(dp_inv[r-1][c-1], min(dp_inv[r-1][c], dp_inv[r-1][c+1]))
				}
			}
			ans += dp_inv[r][c]
		}
	}

	return ans
}