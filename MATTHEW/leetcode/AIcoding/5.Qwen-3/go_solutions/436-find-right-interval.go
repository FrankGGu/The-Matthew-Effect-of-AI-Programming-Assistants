package main

import (
	"sort"
)

func findRightInterval(intervals [][]int) []int {
	n := len(intervals)
	type interval struct {
		start   int
		end     int
		index   int
	}
	intervalsWithIndex := make([]interval, n)
	for i := 0; i < n; i++ {
		intervalsWithIndex[i] = interval{intervals[i][0], intervals[i][1], i}
	}
	sort.Slice(intervalsWithIndex, func(i, j int) bool {
		return intervalsWithIndex[i].start < intervalsWithIndex[j].start
	})
	result := make([]int, n)
	for i := 0; i < n; i++ {
		left, right := 0, n-1
		res := -1
		for left <= right {
			mid := left + (right-left)/2
			if intervalsWithIndex[mid].start >= intervals[i][1] {
				res = intervalsWithIndex[mid].index
				right = mid - 1
			} else {
				left = mid + 1
			}
		}
		result[i] = res
	}
	return result
}