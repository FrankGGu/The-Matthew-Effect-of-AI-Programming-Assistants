package main

import (
	"fmt"
	"sort"
)

func minCost(nums []int) int {
	sort.Ints(nums)
	n := len(nums)
	mid := nums[n/2]
	cost := 0
	for _, num := range nums {
		cost += abs(num - mid)
	}
	return cost
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func main() {
	// Example usage (you can remove this in LeetCode submission)
	nums := []int{1, 2, 3}
	fmt.Println(minCost(nums)) // Output: 2
}