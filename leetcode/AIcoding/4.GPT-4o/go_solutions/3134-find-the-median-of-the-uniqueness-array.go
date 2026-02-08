package main

import (
	"sort"
)

func findMedian(nums []int) float64 {
	uniqueNums := make(map[int]struct{})
	for _, num := range nums {
		uniqueNums[num] = struct{}{}
	}

	uniqueSlice := make([]int, 0, len(uniqueNums))
	for num := range uniqueNums {
		uniqueSlice = append(uniqueSlice, num)
	}

	sort.Ints(uniqueSlice)
	n := len(uniqueSlice)
	if n%2 == 0 {
		return float64(uniqueSlice[n/2-1]+uniqueSlice[n/2]) / 2.0
	}
	return float64(uniqueSlice[n/2])
}