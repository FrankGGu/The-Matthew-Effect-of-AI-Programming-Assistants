import "math"

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minSidewayJumps(obstacles []int) int {
	n := len(obstacles)

	// dp[j] stores the minimum jumps to reach the current point in lane j (0-indexed: 0 for lane 1, 1 for lane 2, 2 for lane 3)
	// Frog starts at point 0, lane 2.
	// To reach lane 1 at point 0: 1 jump from lane 2.
	// To reach lane 2 at point 0: 0 jumps (start).
	// To reach lane 3 at point 0: 1 jump from lane 2.
	dp := []int{1, 0, 1} // Initial state for point 0

	for i := 1; i < n; i++ {
		obs := obstacles[i] // Obstacle lane at current point i (1-indexed)

		current_dp := make([]int, 3)
		for j := 0; j < 3; j++ {
			current_dp[j] = math.MaxInt32
		}

		// Step 1: Consider moving forward from point i-1 to point i in the same lane.
		// If there's an obstacle in lane `j+1` at point `i`, then `current_dp[j]` remains MaxInt32 for now.
		for j := 0; j < 3; j++ {
			if obs != j+1 { // If no obstacle in lane j+1 at point i
				current_dp[j] = dp[j] // Cost is same as reaching i-1 in lane j
			}
		}

		// Step 2: Consider sideway jumps at point `i`.
		// A jump can be made from any lane `k` to any other lane `j` at point `i`, if lane `j` is not blocked.
		// The cost is `current_dp[k] + 1`.
		// We need to use the `current_dp` values *before* these jump calculations for the current point `i`.
		// Let's use `temp_dp_before_jumps` to store these values.
		temp_dp_before_jumps := make([]int, 3)
		copy(temp_dp_before_jumps, current_dp)

		for j := 0; j < 3; j++ { // Target lane j
			if obs == j+1 { // If target lane j has an obstacle, it's unreachable.
				current_dp[j] = math.MaxInt32
				continue
			}

			// Consider jumps from other lanes k to lane j
			// The other two lanes are (j+1)%3 and (j+2)%3

			// Jump from lane (j+1)%3 to lane j
			if temp_dp_before_jumps[(j+1)%3] != math.MaxInt32 {
				current_dp[j] = min(current_dp[j], temp_dp_before_jumps[(j+1)%3]+1)
			}
			// Jump from lane (j+2)%3 to lane j
			if temp_dp_before_jumps[(j+2)%3] != math.MaxInt32 {
				current_dp[j] = min(current_dp[j], temp_dp_before_jumps[(j+2)%3]+1)
			}
		}

		// Update dp for the next iteration
		dp = current_dp
	}

	// The minimum jumps to reach the end (point n-1) in any lane.
	ans := math.MaxInt32
	for j := 0; j < 3; j++ {
		ans = min(ans, dp[j])
	}

	return ans
}