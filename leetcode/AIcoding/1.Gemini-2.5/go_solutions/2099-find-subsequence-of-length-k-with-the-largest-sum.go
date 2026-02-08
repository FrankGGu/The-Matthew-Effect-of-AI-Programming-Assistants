package main

import (
	"sort"
)

type element struct {
	value int
	index int
}

func maxSubsequence(nums []int, k int) []int {
	n := len(nums)
	if k == 0 {
		return []int{}
	}
	if k == n {
		return nums
	}

	elements := make([]element, n)
	for i := 0; i < n; i++ {
		elements[i] = element{value: nums[i], index: i}
	}

	sort.Slice(elements, func(i, j int) bool {
		return elements[i].value > elements[j].value
	})

	topK := make([]element, k)
	copy(topK, elements[:k])

	sort.Slice(topK, func(i, j int) bool {
		return topK[i].index < topK[j].index
	})

	result := make([]int, k)
	for i := 0; i < k; i++ {
		result[i] = topK[i].value
	}

	return result
}