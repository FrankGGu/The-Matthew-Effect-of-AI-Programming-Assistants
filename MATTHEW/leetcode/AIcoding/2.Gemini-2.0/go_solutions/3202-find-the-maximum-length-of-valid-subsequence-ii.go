import "sort"

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func findMaximumLength(nums []int) int {
	sort.Ints(nums)
	n := len(nums)
	dp := make(map[int]int)
	ans := 0
	for i := 0; i < n; i++ {
		val := nums[i]
		cur := 1
		if v, ok := dp[val]; ok {
			cur = max(cur, v+1)
		}
		if val%2 == 0 {
			if v, ok := dp[val/2]; ok {
				cur = max(cur, v+1)
			}
		}
		dp[val*2] = max(dp[val*2], cur)
		ans = max(ans, cur)
	}
	return ans
}