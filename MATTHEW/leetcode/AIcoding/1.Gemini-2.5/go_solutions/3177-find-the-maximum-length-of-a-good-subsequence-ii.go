import "sort"

func findMaximumLength(nums []int, k int) int {
    n := len(nums)

    // dp[j] is a map where dp[j][val] stores the maximum length of a good subsequence
    // ending with value `val` and having exactly `j` changes.
    // We use a