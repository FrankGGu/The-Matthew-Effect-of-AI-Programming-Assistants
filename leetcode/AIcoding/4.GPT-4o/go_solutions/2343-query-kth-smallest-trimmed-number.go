package main

import (
	"sort"
	"strconv"
)

func smallestTrimmedNumbers(nums []string, queries [][]int) []int {
	type query struct {
		k, trim int
		index   int
	}
	qList := make([]query, len(queries))
	for i, q := range queries {
		qList[i] = query{k: q[0], trim: q[1], index: i}
	}
	sort.Slice(qList, func(i, j int) bool {
		return qList[i].trim < qList[j].trim
	})

	results := make([]int, len(queries))
	for _, q := range qList {
		trimmed := make([]string, len(nums))
		for i, num := range nums {
			if len(num) > q.trim {
				trimmed[i] = num[len(num)-q.trim:]
			} else {
				trimmed[i] = num
			}
		}
		sort.Slice(trimmed, func(i, j int) bool {
			if trimmed[i] == trimmed[j] {
				return nums[i] < nums[j]
			}
			return trimmed[i] < trimmed[j]
		})
		results[q.index] = findKthSmallest(nums, trimmed, q.k)
	}

	return results
}

func findKthSmallest(nums, trimmed []string, k int) int {
	for i, num := range nums {
		if trimmed[i] == trimmed[k-1] {
			return i
		}
	}
	return -1
}