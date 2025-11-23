package main

import (
	"sort"
)

func maxSumQueries(nums1 []int, nums2 []int, queries [][]int) []int {
	n := len(nums1)
	m := len(queries)
	type Query struct {
		x, y, index int
	}
	queryStructs := make([]Query, m)
	for i, q := range queries {
		queryStructs[i] = Query{q[0], q[1], i}
	}
	sort.Slice(queryStructs, func(i, j int) bool {
		return queryStructs[i].y < queryStructs[j].y
	})

	type Pair struct {
		num, sum int
	}
	pairs := make([]Pair, n)
	for i := 0; i < n; i++ {
		pairs[i] = Pair{nums2[i], nums1[i]}
	}
	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i].num < pairs[j].num
	})

	res := make([]int, m)
	maxSum := 0
	j := 0
	sums := []int{}
	for _, q := range queryStructs {
		for j < n && pairs[j].num <= q.y {
			sums = append(sums, pairs[j].sum)
			j++
		}
		if len(sums) > 0 {
			sort.Sort(sort.Reverse(sort.IntSlice(sums)))
			maxSum = max(maxSum, sums[0])
		}
		res[q.index] = maxSum
	}
	return res
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}