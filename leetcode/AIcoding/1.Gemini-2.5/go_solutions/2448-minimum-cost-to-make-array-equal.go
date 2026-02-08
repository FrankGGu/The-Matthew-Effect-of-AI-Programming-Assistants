package main

import (
	"sort"
)

type pair struct {
	num  int
	cost int
}

func minCost(nums []int, cost []int) int64 {
	n := len(nums)
	pairs := make([]pair, n)
	for i := 0; i < n; i++ {
		pairs[i] = pair{num: nums[i], cost: cost[i]}
	}

	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i].num < pairs[j].num
	})

	var totalCostSum int64
	for i := 0; i < n; i++ {
		totalCostSum += int64(pairs[i].cost)
	}

	var currentCostSum int64
	var optimalX int
	for i := 0; i < n; i++ {
		currentCostSum += int64(pairs[i].cost)
		if currentCostSum*2 >= totalCostSum { // Equivalent to currentCostSum >= totalCostSum / 2.0
			optimalX = pairs[i].num
			break
		}
	}

	var minTotalCost int64
	for i := 0; i < n; i++ {
		minTotalCost += abs(int64(nums[i])-int64(optimalX)) * int64(cost[i])
	}

	return minTotalCost
}

func abs(x int64) int64 {
	if x < 0 {
		return -x
	}
	return x
}