package main

import (
	"sort"
)

func permuteUnique(nums []int) [][]int {
	sort.Ints(nums)
	result := [][]int{}
	path := []int{}
	used := make([]bool, len(nums))

	var backtrack func()
	backtrack = func() {
		if len(path) == len(nums) {
			temp := make([]int, len(path))
			copy(temp, path)
			result = append(result, temp)
			return
		}

		for i := 0; i < len(nums); i++ {
			if used[i] {
				continue
			}
			// Skip duplicates: if current element is same as previous AND previous was not used,
			// it means we are in a new branch and using nums[i] would lead to a duplicate permutation
			// already explored by using nums[i-1] in a previous branch.
			if i > 0 && nums[i] == nums[i-1] && !used[i-1] {
				continue
			}

			path = append(path, nums[i])
			used[i] = true
			backtrack()
			used[i] = false
			path = path[:len(path)-1]
		}
	}

	backtrack()
	return result
}