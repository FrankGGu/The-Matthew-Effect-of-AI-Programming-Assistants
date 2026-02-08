func minimumRightShifts(nums []int) int {
	n := len(nums)
	sorted := true
	for i := 1; i < n; i++ {
		if nums[i] < nums[i-1] {
			sorted = false
			break
		}
	}
	if sorted {
		return 0
	}

	for k := 1; k < n; k++ {
		rotated := make([]int, n)
		for i := 0; i < n; i++ {
			rotated[i] = nums[(i-k+n)%n]
		}
		sorted := true
		for i := 1; i < n; i++ {
			if rotated[i] < rotated[i-1] {
				sorted = false
				break
			}
		}
		if sorted {
			return k
		}
	}

	return -1
}