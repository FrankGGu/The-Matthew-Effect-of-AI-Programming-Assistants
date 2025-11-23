package main

import "math"

func minOperations(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])
	maxDigit := 9
	INF := math.MaxInt64 / 2 // A sufficiently large number to avoid overflow when adding/subtracting

	// dp[j][val] represents the minimum operations for the subgrid (0,0) to (i,j)
	// such that grid[i][j] is val.
	// We use two rows for space optimization: prev_dp for row i-1, curr_dp for row i.
	prev_dp := make([][]int, n) // dp for row i-1
	curr_dp := make([][]int, n) // dp for row i

	for j := 0; j < n; j++ {
		prev_dp[j] = make([]int, maxDigit+1)
		curr_dp[j] = make([]int, maxDigit+1)
		for val := 0; val <= maxDigit; val++ {
			prev_dp[j][val] = INF
			curr_dp[j][val] = INF
		}
	}

	// Helper functions for min/max/add/sub with INF
	min := func(a, b int) int {
		if a < b {
			return a
		}
		return b
	}
	max := func(a, b int) int {
		if a > b {
			return a
		}
		return b
	}
	add := func(a, b int) int {
		if a == INF || b == INF {
			return INF
		}
		return a + b
	}
	sub := func(a, b int) int {
		if a == INF || b == INF {
			return INF
		}
		return a - b
	}

	// Base case: grid[0][0]
	for val := 0; val <= maxDigit; val++ {
		cost_00 := max(0, val-grid[0][0])
		if val < grid[0][0] { // Cannot decrease value
			cost_00 = INF
		}
		curr_dp[0][val] = cost_00
	}

	// First row (i=0)
	for j := 1; j < n; j++ {
		prefixMinLeft := make([]int, maxDigit+1)
		prefixMinLeft[0] = curr_dp[j-1][0]
		for k := 1; k <= maxDigit; k++ {
			prefixMinLeft[k] = min(prefixMinLeft[k-1], curr_dp[j-1][k])
		}

		for val := 0; val <= maxDigit; val++ {
			cost_0j := max(0, val-grid[0][j])
			if val < grid[0][j] {
				cost_0j = INF
			}
			curr_dp[j][val] = add(cost_0j, prefixMinLeft[val])
		}
	}

	// Now prev_dp holds results for row 0. We will swap curr_dp and prev_dp.
	// For the loop, prev_dp will be row i-1, curr_dp will be row i.
	prev_dp, curr_dp = curr_dp, prev_dp

	// Iterate for rows i from 1 to m-1
	for i := 1; i < m; i++ {
		// Clear curr_dp for the new row i
		for j := 0; j < n; j++ {
			for val := 0; val <= maxDigit; val++ {
				curr_dp[j][val] = INF
			}
		}

		// First column of current row (j=0)
		prefixMinUp := make([]int, maxDigit+1)
		prefixMinUp[0] = prev_dp[0][0]
		for k := 1; k <= maxDigit; k++ {
			prefixMinUp[k] = min(prefixMinUp[k-1], prev_dp[0][k])
		}

		for val := 0; val <= maxDigit; val++ {
			cost_i0 := max(0, val-grid[i][0])
			if val < grid[i][0] {
				cost_i0 = INF
			}
			curr_dp[0][val] = add(cost_i0, prefixMinUp[val])
		}

		// Remaining cells (j from 1 to n-1)
		for j := 1; j < n; j++ {
			// C[k] = prefix_min_diag[k] = min_{0 <= x <= k} (prev_dp[j-1][x])
			prefixMinDiag := make([]int, maxDigit+1)
			prefixMinDiag[0] = prev_dp[j-1][0]
			for k := 1; k <= maxDigit; k++ {
				prefixMinDiag[k] = min(prefixMinDiag[k-1], prev_dp[j-1][k])
			}

			// P1[k] = min_{0 <= x <= k} (curr_dp[j-1][x] - prefixMinDiag[x])
			tmp_P1 := make([]int, maxDigit+1)
			tmp_P1[0] = sub(curr_dp[j-1][0], prefixMinDiag[0])
			for k := 1; k <= maxDigit; k++ {
				tmp_P1[k] = min(tmp_P1[k-1], sub(curr_dp[j-1][k], prefixMinDiag[k]))
			}

			// P2[k] = min_{k < x <= maxDigit} (curr_dp[j-1][x]) (suffix min)
			tmp_P2 := make([]int, maxDigit+1)
			tmp_P2[maxDigit] = INF // For x > maxDigit, this range is empty
			for k := maxDigit - 1; k >= 0; k-- {
				tmp_P2[k] = min(tmp_P2[k+1], curr_dp[j-1][k+1])
			}

			// f_v_up[v_up] = min(P1[v_up], P2[v_up] - C[v_up])
			f_v_up := make([]int, maxDigit+1)
			for v_up := 0; v_up <= maxDigit; v_up++ {
				term1 := tmp_P1[v_up]
				term2 := INF
				if v_up < maxDigit { // P2[v_up] is min_{x > v_up} B[x]
					term2 = sub(tmp_P2[v_up], prefixMinDiag[v_up])
				}
				f_v_up[v_up] = min(term1, term2)
			}

			// Calculate curr_dp[j][val]
			for val := 0; val <= maxDigit; val++ {
				cost_ij := max(0, val-grid[i][j])
				if val < grid[i][j] {
					cost_ij = INF
				}
				if cost_ij == INF {
					curr_dp[j][val] = INF
					continue
				}

				min_term_sum := INF
				// A[v_up] = prev_dp[j][v_up]
				for v_up := 0; v_up <= val; v_up++ {
					min_term_sum = min(min_term_sum, add(prev_dp[j][v_up], f_v_up[v_up]))
				}
				curr_dp[j][val] = add(cost_ij, min_term_sum)
			}
		}
		prev_dp, curr_dp = curr_dp, prev_dp // Swap for next row
	}

	// The final answer is the minimum value in the last row (prev_dp holds it now)
	ans := INF
	for val := 0; val <= maxDigit; val++ {
		ans = min(ans, prev_dp[n-1][val])
	}

	return ans
}