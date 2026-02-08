package main

import (
	"math"
	"sort"
)

func minCost(basket1 []int, basket2 []int) int64 {
	allCounts := make(map[int]int)
	map1 := make(map[int]int)
	map2 := make(map[int]int)

	minVal := math.MaxInt32

	for _, fruit := range basket1 {
		allCounts[fruit]++
		map1[fruit]++
		if fruit < minVal {
			minVal = fruit
		}
	}
	for _, fruit := range basket2 {
		allCounts[fruit]++
		map2[fruit]++
		if fruit < minVal {
			minVal = fruit
		}
	}

	for _, count := range allCounts {
		if count%2 != 0 {
			return -1
		}
	}

	excess1 := []int{}
	excess2 := []int{}

	for fruit, count := range allCounts {
		targetCount := count / 2
		diff1 := map1[fruit] - targetCount
		diff2 := map2[fruit] - targetCount

		for i := 0; i < diff1; i++ {
			excess1 = append(excess1, fruit)
		}
		for i := 0; i < diff2; i++ {
			excess2 = append(excess2, fruit)
		}
	}

	sort.Ints(excess1)
	sort.Ints(excess2)

	var totalCost int64
	k := len(excess1) // len(excess1) == len(excess2)

	for i := 0; i < k; i++ {
		costDirect := int64(min(excess1[i], excess2[i]))
		costIndirect := int64(2 * minVal)
		totalCost += min64(costDirect, costIndirect)
	}

	return totalCost
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func min64(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}