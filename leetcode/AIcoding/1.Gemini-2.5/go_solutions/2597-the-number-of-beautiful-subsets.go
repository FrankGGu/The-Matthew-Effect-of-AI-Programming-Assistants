package main

import (
	"sort"
)

var (
	result int
	kVal   int
	numsArr []int
	freq   map[int]int
)

func backtrack(idx int) {
	if idx == len(numsArr) {
		if len(freq) > 0 {
			result++
		}
		return
	}

	// Option 1: Don't include numsArr[idx]
	backtrack(idx + 1)

	// Option 2: Try to include numsArr[idx]
	currentNum := numsArr[idx]

	// Check if adding currentNum violates the beautiful condition
	// A number 'x' cannot be added if 'x - k' or 'x + k' is already in the subset.
	// Since numsArr contains distinct elements, freq[currentNum] will be 0 if not present.
	if freq[currentNum-kVal] == 0 && freq[currentNum+kVal] == 0 {
		freq[currentNum]++
		backtrack(idx + 1)
		freq[currentNum]--
		if freq[currentNum] == 0 {
			delete(freq, currentNum)
		}
	}
}

func beautifulSubsets(nums []int, k int) int {
	numsArr = nums
	kVal = k
	result = 0
	freq = make(map[int]int)

	sort.Ints(numsArr)

	backtrack(0)

	return result
}