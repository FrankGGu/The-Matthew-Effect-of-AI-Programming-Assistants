func minOperations(nums []int, k int) int {
	n := len(nums)
	dp := make([]int, n+1)
	for i := 1; i <= n; i++ {
		dp[i] = i
		for j := 1; j <= k && i-j >= 0; j++ {
			cost := dp[i-j]
			counts := make(map[int]int)
			for l := i - j; l < i; l++ {
				counts[nums[l]]++
			}
			maxCount := 0
			for _, count := range counts {
				if count > maxCount {
					maxCount = count
				}
			}
			cost += j - maxCount
			if cost < dp[i] {
				dp[i] = cost
			}
		}
	}
	return dp[n]
}