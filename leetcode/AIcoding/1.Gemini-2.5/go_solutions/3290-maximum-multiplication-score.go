import "math"

func maximumMultiplicationScore(nums []int, multipliers []int) int {
    n := len(nums)
    m := len(multipliers)

    // dp[j] represents the maximum score when 'j' elements have been picked from the left
    // and 'k' total operations have been performed (where