func solve(nums []int) []int {
	n := len(nums)
	ans := make([]int, n)
	for i := 0; i < n; i++ {
		ans[i] = nums[i]
	}

	for i := 0; i < n-1; i++ {
		if ans[i] == 0 && ans[i+1] == 0 {
			continue
		}
		if ans[i] == 0 && ans[i+1] != 0 {
			ans[i], ans[i+1] = ans[i+1], 0
		}
	}

	return ans
}

func transformArray(nums []int) []int {
	n := len(nums)
	zeros := 0
	for _, num := range nums {
		if num == 0 {
			zeros++
		}
	}
	result := make([]int, n)
	for i := 0; i < zeros; i++ {
		result[i] = 0
	}
	j := zeros
	for i := 0; i < n; i++ {
		if nums[i] != 0 {
			result[j] = nums[i]
			j++
		}
	}
	return result
}