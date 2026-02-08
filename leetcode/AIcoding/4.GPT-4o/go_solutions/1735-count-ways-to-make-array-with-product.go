package main

import (
	"fmt"
	"math"
)

const mod = 1_000_000_007

func countWays(nums []int, target int64) int {
	n := len(nums)
	dp := make([]int, target+1)
	dp[1] = 1

	for _, num := range nums {
		for j := target; j >= num; j-- {
			dp[j] = (dp[j] + dp[j/num]) % mod
		}
	}
	return dp[target]
}

func main() {
	nums := []int{2, 4}
	target := int64(8)
	fmt.Println(countWays(nums, target))
}