package main

import (
	"math"
	"sort"
)

func minimumAbsoluteDifference(arr []int) [][]int {
	sort.Ints(arr)

	minDiff := math.MaxInt32
	for i := 0; i < len(arr)-1; i++ {
		diff := arr[i+1] - arr[i]
		if diff < minDiff {
			minDiff = diff
		}
	}

	var result [][]int
	for i := 0; i < len(arr)-1; i++ {
		if arr[i+1]-arr[i] == minDiff {
			result = append(result, []int{arr[i], arr[i+1]})
		}
	}

	return result
}