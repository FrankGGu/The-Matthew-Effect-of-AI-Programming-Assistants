import "math"

func findNumberOfLIS(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    dp := make([]int, n)    // dp[i] stores the length of the longest increasing subsequence ending at index i