func semiOrderedPermutation(nums []int) int {
	n := len(nums)
	pos1 := 0
	posN := 0
	for i := 0; i < n; i++ {
		if nums[i] == 1 {
			pos1 = i
		}
		if nums[i] == n {
			posN = i
		}
	}

	ans := pos1 + (n - 1 - posN)
	if pos1 > posN {
		ans--
	}
	return ans
}