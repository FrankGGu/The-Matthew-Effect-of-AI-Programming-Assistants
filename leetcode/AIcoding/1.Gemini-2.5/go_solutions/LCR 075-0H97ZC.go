package main

import (
	"sort"
)

func relativeSortArray(arr1 []int, arr2 []int) []int {
	counts := make([]int, 1001)
	for _, num := range arr1 {
		counts[num]++
	}

	result := make([]int, 0, len(arr1))

	for _, num := range arr2 {
		for counts[num] > 0 {
			result = append(result, num)
			counts[num]--
		}
	}

	for i := 0; i <= 1000; i++ {
		for counts[i] > 0 {
			result = append(result, i)
			counts[i]--
		}
	}

	return result
}