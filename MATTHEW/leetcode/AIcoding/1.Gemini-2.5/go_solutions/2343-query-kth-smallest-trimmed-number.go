package main

import (
	"sort"
)

type trimmedNum struct {
	val string
	idx int
}

type trimmedNums []trimmedNum

func (t trimmedNums) Len() int { return len(t) }
func (t trimmedNums) Less(i, j int) bool {
	if t[i].val == t[j].val {
		return t[i].idx < t[j].idx
	}
	return t[i].val < t[j].val
}
func (t trimmedNums) Swap(i, j int) { t[i], t[j] = t[j], t[i] }

func kthSmallestTrimmedNumber(nums []string, queries [][]int) []int {
	results := make([]int, len(queries))

	for qIdx, query := range queries {
		k := query[0]
		trim := query[1]

		currentNums := make(trimmedNums, len(nums))
		for i, numStr := range nums {
			trimmedVal := ""
			if len(numStr) <= trim {
				trimmedVal = numStr
			} else {
				trimmedVal = numStr[len(numStr)-trim:]
			}
			currentNums[i] = trimmedNum{val: trimmedVal, idx: i}
		}

		sort.Sort(currentNums)

		results[qIdx] = currentNums[k-1].idx
	}

	return results
}