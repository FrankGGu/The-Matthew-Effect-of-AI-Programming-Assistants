func beautifulSubsets(nums []int, k int) int {
	count := 0
	n := len(nums)

	var backtrack func(index int, subset []int)
	backtrack = func(index int, subset []int) {
		if index == n {
			if len(subset) > 0 {
				count++
			}
			return
		}

		// Exclude nums[index]
		backtrack(index+1, subset)

		// Include nums[index]
		valid := true
		for _, num := range subset {
			if abs(num-nums[index]) == k {
				valid = false
				break
			}
		}
		if valid {
			newSubset := append([]int{}, subset...)
			newSubset = append(newSubset, nums[index])
			backtrack(index+1, newSubset)
		}
	}

	backtrack(0, []int{})
	return count
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}