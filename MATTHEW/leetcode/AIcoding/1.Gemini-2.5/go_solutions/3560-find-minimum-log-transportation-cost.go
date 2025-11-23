import "math"

func minCost(n int, logs []int, truckCapacity int, truckCost int, splitCost int) int {
    dp := make([]int, n+1)
    dp[0] = 0 // Cost to transport 0 logs is 0.

    // Initialize dp values for logs[1...n] to