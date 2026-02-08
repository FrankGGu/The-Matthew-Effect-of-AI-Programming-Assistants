package main

import (
	"sort"
)

func removeBeans(beans []int) int64 {
	sort.Ints(beans)

	var totalSum int64
	for _, b := range beans {
		totalSum += int64(b)
	}

	minRemoved := totalSum // Initialize with the case where all beans are removed

	n := len(beans)
	for i := 0; i < n; i++ {
		// If we decide that beans[i] is the minimum number of beans in any remaining non-empty bag:
		// 1. All bags with fewer than beans[i] beans (i.e., beans[0]...beans[i-1]) must be completely emptied.
		// 2. All bags with at least beans[i] beans (i.e., beans[i]...beans[n-1]) will have beans removed
		//    until they contain exactly beans[i] beans.
		//
		// The total number of beans that would remain in the bags beans[i]...beans[n-1]
		// if they all contained exactly beans[i] beans would be:
		// (number of bags from index i to n-1) * beans[i]
		// which is (n - i) * beans[i].
		//
		// The total beans removed in this scenario is:
		// (total sum of all beans) - (beans that would remain)
		// totalSum - (int64(n-i) * int64(beans[i]))

		currentRemainingBeans := int64(n-i) * int64(beans[i])
		currentRemoved := totalSum - currentRemainingBeans

		if currentRemoved < minRemoved {
			minRemoved = currentRemoved
		}
	}

	return minRemoved
}