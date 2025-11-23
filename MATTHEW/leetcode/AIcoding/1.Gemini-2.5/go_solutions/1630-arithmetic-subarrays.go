package main

import (
	"sort"
)

func checkArithmeticSubarrays(nums []int, l []int, r []int) []bool {
	m := len(l)
	result := make([]bool, m)

	for i := 0; i < m; i++ {
		start := l[i]
		end := r[i]

		subArrayLen := end - start + 1

		if subArrayLen < 2 {
			result[i] = false
			continue
		}

		currentSub := make([]int, subArrayLen)
		copy(currentSub, nums[start:end+1])

		sort.Ints(currentSub)

		isArithmetic := true
		diff := currentSub[1] - currentSub[0]
		for j := 2; j < subArrayLen; j++ {
			if currentSub[j]-currentSub[j-1] != diff {
				isArithmetic = false
				break
			}
		}

		result[i] = isArithmetic
	}

	return result
}