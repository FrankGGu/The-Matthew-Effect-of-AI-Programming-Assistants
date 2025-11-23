package main

func findSubsequences(nums []int) [][]int {
	var result [][]int
	var path []int

	var backtrack func(start int)
	backtrack = func(start int) {
		if len(path) >= 2 {
			temp := make([]int, len(path))
			copy(temp, path)
			result = append(result, temp)
		}

		used := make(map[int]bool)
		for i := start; i < len(nums); i++ {
			if used[nums[i]] {
				continue
			}
			if len(path) > 0 && nums[i] < path[len(path)-1] {
				continue
			}
			used[nums[i]] = true
			path = append(path, nums[i])
			backtrack(i + 1)
			path = path[:len(path)-1]
		}
	}

	backtrack(0)
	return result
}