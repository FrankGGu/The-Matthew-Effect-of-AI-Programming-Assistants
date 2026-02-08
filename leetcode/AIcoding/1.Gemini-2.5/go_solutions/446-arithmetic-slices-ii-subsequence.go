package main

func numberOfArithmeticSlices(nums []int) int {
	n := len(nums)
	if n < 3 {
		return 0
	}

	ans := 0
	// dp[i] is a map where keys are common differences and values are the count
	// of arithmetic subsequences of length at least 2, ending at nums[i]
	// with that common difference.
	dp := make([]map[int64]int, n)
	for i := 0; i < n; i++ {
		dp[i] = make(map[int64]int)
	}

	for i := 1; i < n; i++ {
		for j := 0; j < i; j++ {
			diff := int64(nums[i]) - int64(nums[j])

			// countFromJ represents the number of arithmetic subsequences of length >= 2
			// ending at nums[j] with the common difference 'diff'.
			// When nums[i] is appended to these subsequences, they become
			// arithmetic subsequences of length >= 3, ending at nums[i].
			// These are added to the total answer.
			countFromJ := dp[j][diff]
			ans += countFromJ

			// Update dp[i][diff]:
			// 1. Add 1 for the new arithmetic subsequence of length 2: [nums[j], nums[i]].
			// 2. Add countFromJ for all arithmetic subsequences of length >= 2
			//    ending at nums[j] with 'diff', extended by nums[i].
			dp[i][diff] += countFromJ + 1
		}
	}

	return ans
}