package main

func maxResult(nums []int, k int) int {
	n := len(nums)
	if n == 0 {
		return 0
	}

	dp := make([]int, n)
	dp[0] = nums[0]

	deque := []int{0} // Stores indices, sorted by dp value in decreasing order

	for i := 1; i < n; i++ {
		// Remove indices from the front that are out of the current window [i-k, i-1]
		for len(deque) > 0 && deque[0] < i-k {
			deque = deque[1:]
		}

		// The maximum score to reach an index in the window [i-k, i-1] is dp[deque[0]]
		dp[i] = nums[i] + dp[deque[0]]

		// Remove indices from the back whose dp values are less than or equal to dp[i]
		// because dp[i] is a better candidate (larger score, or same score but closer to i)
		for len(deque) > 0 && dp[deque[len(deque)-1]] <= dp[i] {
			deque = deque[:len(deque)-1]
		}

		// Add current index i to the back of the deque
		deque = append(deque, i)
	}

	return dp[n-1]
}