package main

func minimizeMax(nums []int, p int) int {
	sort.Ints(nums)
	n := len(nums)
	dp := make([]int, n)
	for i := 1; i < n; i++ {
		dp[i] = dp[i-1]
		if i >= 1 {
			dp[i] = min(dp[i], dp[i-2]+nums[i]-nums[i-1])
		}
	}
	return dp[n-1]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}