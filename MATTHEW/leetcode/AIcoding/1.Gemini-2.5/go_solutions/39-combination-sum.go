package main

import (
	"sort"
)

func combinationSum(candidates []int, target int) [][]int {
	sort.Ints(candidates)
	result := [][]int{}
	currentCombination := []int{}

	var backtrack func(start int, currentSum int)
	backtrack = func(start int, currentSum int) {
		if currentSum == target {
			temp := make([]int, len(currentCombination))
			copy(temp, currentCombination)
			result = append(result, temp)
			return
		}

		if currentSum > target {
			return
		}

		for i := start; i < len(candidates); i++ {
			if currentSum + candidates[i] > target {
				break 
			}
			currentCombination = append(currentCombination, candidates[i])
			backtrack(i, currentSum + candidates[i])
			currentCombination = currentCombination[:len(currentCombination)-1]
		}
	}

	backtrack(0, 0)
	return result
}