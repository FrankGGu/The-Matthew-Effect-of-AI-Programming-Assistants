import (
	"sort"
)

func minimumArraySum(nums []int) int {
	sort.Ints(nums)
	n := len(nums)
	dp := make([]int, n)
	dp[0] = nums[0]
	for i := 1; i < n; i++ {
		if dp[i-1] > nums[i] {
			dp[i] = dp[i-1]
		} else {
			dp[i] = nums[i]
		}
		dp[i] += nums[i]
	}
	return dp[n-1]
}