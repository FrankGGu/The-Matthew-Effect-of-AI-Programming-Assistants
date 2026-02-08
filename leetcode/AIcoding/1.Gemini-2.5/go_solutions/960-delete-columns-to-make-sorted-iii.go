package main

import "math"

func minDeletionSize(A []string) int {
	N := len(A)
	if N == 0 {
		return 0
	}
	M := len(A[0])
	if M == 0 {
		return 0
	}

	// dp[j] stores the maximum length of a valid subsequence of columns ending at index j.
	// A value of -1 indicates that column j alone cannot form a valid subsequence.
	dp := make([]int, M)

	// isEqual[j][r] is true if the string formed by the subsequence ending at j
	// for row r is lexicographically equal to the string formed for row r+1.
	isEqual := make([][]bool, M)

	// Initialize dp and isEqual for single-column subsequences
	for j := 0; j < M; j++ {
		dp[j] = 1 // Assume column j can form a subsequence of length 1
		isEqual[j] = make([]bool, N-1)

		isCurrentColValid := true
		for r := 0; r < N-1; r++ {
			if A[r][j] > A[r+1][j] {
				isCurrentColValid = false
				break
			} else if A[r][j] == A[r+1][j] {
				isEqual[j][r] = true
			}
			// If A[r][j] < A[r+1][j], isEqual[j][r] remains false
		}

		if !isCurrentColValid {
			dp[j] = -1 // Column j alone is not a valid subsequence
		}
	}

	// Dynamic programming to find the longest valid subsequence
	for j := 0; j < M; j++ {
		if dp[j] == -1 { // If column j alone is invalid, it cannot be the end of any valid sequence starting with itself
			continue
		}

		for i := 0; i < j; i++ {
			if dp[i] == -1 { // If column i alone is invalid, it cannot be a valid predecessor
				continue
			}

			canExtendWithJ := true
			newIsEqualForJExtendingI := make([]bool, N-1)

			for r := 0; r < N-1; r++ {
				if isEqual[i][r] { // The prefix S_r(i) == S_{r+1}(i)
					if A[r][j] > A[r+1][j] {
						canExtendWithJ = false
						break
					} else if A[r][j] < A[r+1][j] {
						newIsEqualForJExtendingI[r] = false
					} else { // A[r][j] == A[r+1][j]
						newIsEqualForJExtendingI[r] = true
					}
				} else { // The prefix S_r(i) < S_{r+1}(i), so adding A[r][j] and A[r+1][j] won't break the order
					newIsEqualForJExtendingI[r] = false
				}
			}

			if canExtendWithJ {
				if dp[i]+1 > dp[j] {
					dp[j] = dp[i] + 1
					isEqual[j] = newIsEqualForJExtendingI
				} else if dp[i]+1 == dp[j] {
					// Tie-breaking rule: if two subsequences have the same maximum length,
					// choose the one that results in fewer equal pairs (more strict inequalities),
					// as this provides more flexibility for future extensions.
					currentTrueCount := countTrue(isEqual[j])
					newTrueCount := countTrue(newIsEqualForJExtendingI)
					if newTrueCount < currentTrueCount {
						isEqual[j] = newIsEqualForJExtendingI
					}
				}
			}
		}
	}

	maxKept := 0
	for _, length := range dp {
		if length > maxKept {
			maxKept = length
		}
	}

	return M - maxKept
}

func countTrue(arr []bool) int {
	count := 0
	for _, b := range arr {
		if b {
			count++
		}
	}
	return count
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}