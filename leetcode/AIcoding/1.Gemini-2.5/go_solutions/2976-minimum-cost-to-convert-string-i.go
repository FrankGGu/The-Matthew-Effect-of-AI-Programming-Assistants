import "math"

func minimumCost(source string, target string, original []byte, changed []byte, cost []int) int64 {
	// Step 1: Initialize adjacency matrix for character transformation costs
	// Use a 26x26 matrix for 'a' through 'z'
	// costs[i][j] will store the