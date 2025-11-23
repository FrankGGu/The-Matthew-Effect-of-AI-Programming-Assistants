func maxAndSum(nums []int, numSlots int) int {
	n := len(nums)
	maxMask := 1 << (2 * numSlots)

	// dp[i][mask] stores the maximum AND sum using the first 'i' numbers from nums,
	// with the slots in the state represented by 'mask'.
	// Each slot 'j' (0 to numSlots-1) uses 2 bits in the mask:
	// 00 (0): empty
	// 01 (1): one number assigned
	// 10 (2): two numbers assigned
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, maxMask)
		for j := range dp[i] {
			dp[i][j] = -1 // Initialize with -1 to indicate unreachable states
		}
	}

	dp[0][0] = 0 // Base case: 0 numbers used, 0 sum, empty slots

	for i := 0; i < n; i++ { // Iterate through each number in nums (nums[i])
		for mask := 0; mask < maxMask; mask++ { // Iterate through all possible slot states
			if dp[i][mask] == -1 { // If current state is unreachable, skip
				continue
			}

			// Try to place nums[i] into each slot
			for j := 0; j < numSlots; j++ { // Slot index j, slot value (j+1)
				slotState := (mask >> (2 * j)) & 3 // Get current state of slot j

				if slotState < 2 { // If slot j can accept another number (state 0 or 1)
					newSlotState := slotState + 1

					// Calculate the next mask by updating slot j's state
					// Clear current 2 bits for slot j, then set new 2 bits
					nextMask := (mask & ^(3 << (2 * j))) | (newSlotState << (2 * j))

					// Update dp[i+1][nextMask] with the maximum sum
					currentSum := dp[i][mask] + (nums[i] & (j + 1))
					if currentSum > dp[i+1][nextMask] {
						dp[i+1][nextMask] = currentSum
					}
				}
			}
		}
	}

	// The final answer is the maximum value in the last row of the DP table
	// (after all 'n' numbers have been placed).
	maxSum := 0
	for mask := 0; mask < maxMask; mask++ {
		if dp[n][mask] > maxSum {
			maxSum = dp[n][mask]
		}
	}

	return maxSum
}