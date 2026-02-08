import "math"

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}

func maxScore(nums []int, x int) int64 {
	n := len(nums)

	// dp[0] stores the maximum score ending with an even number.
	// dp[1] stores the maximum score ending with an odd number.
	// Initialize with math.MinInt64 to represent an unreachable state.
	dp := [2]int64{math.MinInt64, math.MinInt64}

	// The first element nums[0] is always included in the score.
	// It forms the base case for our DP.
	firstNum := int64(nums[0])
	firstParity := firstNum % 2
	dp[firstParity] = firstNum

	// Iterate from the second element to the end of the array.
	for i := 1; i < n; i++ {
		currentNum := int64(nums[i])
		currentParity := currentNum % 2
		otherParity := 1 - currentParity

		// Calculate the score if we choose to include currentNum as the last element
		// in a path. This score is based on extending a previous path.

		// Option 1: Extend a path that ended with a number of the same parity.
		// This is only possible if dp[currentParity] was reachable.
		scoreFromSameParity := math.MinInt64
		if dp[currentParity] != math.MinInt64 {
			scoreFromSameParity = dp[currentParity] + currentNum
		}

		// Option 2: Extend a path that ended with a number of the other parity.
		// This is only possible if dp[otherParity] was reachable.
		// There's a cost 'x' for switching parities.
		scoreFromOtherParity := math.MinInt64
		if dp[otherParity] != math.MinInt64 {
			scoreFromOtherParity = dp[otherParity] + currentNum - int64(x)
		}

		// The maximum score if we pick currentNum as the last element is the best of these two options.
		scoreIfPickingCurrent := max(scoreFromSameParity, scoreFromOtherParity)

		// Update dp[currentParity].
		// We take the maximum of:
		// 1. The existing best score ending with currentParity (meaning we don't pick currentNum).
		// 2. The score obtained if we pick currentNum as the last element.
		// This allows for skipping currentNum if it doesn't improve the score for its parity.
		dp[currentParity] = max(dp[currentParity], scoreIfPickingCurrent)
	}

	// The final answer is the maximum of the best scores ending with an even or odd number.
	return max(dp[0], dp[1])
}