package main

import (
	"fmt"
)

const MOD = 1e9 + 7

func pathsWithMaxScore(board []string) []int {
	rows := len(board)
	cols := len(board[0])

	// dp[r][c] stores [max_score_from_rc_to_S, num_paths_from_rc_to_S]
	// Initialize with [-1, 0] to indicate unreachable
	dp := make([][][2]int, rows)
	for i := range dp {
		dp[i] = make([][2]int, cols)
		for j := range dp[i] {
			dp[i][j][0] = -1 // Max score
			dp[i][j][1] = 0  // Number of paths
		}
	}

	// Find coordinates of 'S' and 'E'
	s_r, s_c := 0, 0
	e_r, e_c := 0, 0
	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			if board[r][c] == 'S' {
				s_r, s_c = r, c
			} else if board[r][c] == 'E' {
				e_r, e_c = r, c
			}
		}
	}

	// Base case: At 'S' cell, score from S to S is 0, 1 path
	dp[s_r][s_c][0] = 0
	dp[s_r][s_c][1] = 1

	// Iterate from 'S' (destination) backwards to 'E' (source)
	// The allowed moves are (r-1, c), (r, c-1), or (r-1, c-1).
	// This means to reach (r,c), we must have come from (r+1,c), (r,c+1), or (r+1,c+1).
	// So, we iterate r and c from bottom-right towards top-left.
	for r := rows - 1; r >= 0; r-- {
		for c := cols - 1; c >= 0; c-- {
			// Skip obstacles
			if board[r][c] == 'X' {
				continue
			}
			// Skip 'S' cell, as it's the base case already handled
			if r == s_r && c == s_c {
				continue
			}

			// Collect scores and paths from reachable neighbors (down, right, down-right)
			// These are the cells that can move to (r,c) in the reverse direction of DP calculation
			options := [][2]int{}

			// From (r+1, c) (down)
			if r+1 < rows && dp[r+1][c][0] != -1 {
				options = append(options, dp[r+1][c])
			}
			// From (r, c+1) (right)
			if c+1 < cols && dp[r][c+1][0] != -1 {
				options = append(options, dp[r][c+1])
			}
			// From (r+1, c+1) (down-right / diagonal)
			if r+1 < rows && c+1 < cols && dp[r+1][c+1][0] != -1 {
				options = append(options, dp[r+1][c+1])
			}

			maxPrevScore := -1
			numPaths := 0

			for _, opt := range options {
				score, paths := opt[0], opt[1]
				if score > maxPrevScore {
					maxPrevScore = score
					numPaths = paths
				} else if score == maxPrevScore {
					numPaths = (numPaths + paths) % MOD
				}
			}

			if maxPrevScore == -1 { // No reachable path from any neighbor
				dp[r][c][0] = -1
				dp[r][c][1] = 0
			} else {
				cellVal := 0
				// Score is inclusive of 'S', but exclusive of 'E'.
				// 'S' itself is a character, not a digit, so its value is 0.
				// 'E' is also a character, and its value is 0 as it's exclusive.
				// Only numeric characters contribute to the score.
				if board[r][c] >= '0' && board[r][c] <= '9' {
					cellVal = int(board[r][c] - '0')
				}

				dp[r][c][0] = maxPrevScore + cellVal
				dp[r][c][1] = numPaths
			}
		}
	}

	// The final result is at the 'E' cell (source)
	if dp[e_r][e_c][0] == -1 {
		return []int{0, 0}
	}
	return dp[e_r][e_c]
}