import "slices"

func maximumLength(nums []int, k int) int {
	// dp[r] stores the maximum length of a valid subsequence
	// whose last element has a remainder of 'r' when divided by 'k'.
	dp := make([]int, k)
	maxLen := 0