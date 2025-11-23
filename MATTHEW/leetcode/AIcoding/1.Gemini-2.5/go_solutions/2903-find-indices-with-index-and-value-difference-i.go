func absInt(a int) int {
	if a < 0 {
		return -a
	}
	return a
}

func findIndices(nums []int, indexDifference int, valueDifference int) []int {
	n := len(nums)
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if absInt(i-j) >= indexDifference && absInt(nums[i]-nums[j]) >= valueDifference {
				return []int{i, j}
			}
		}
	}
	return []int{-1, -1}
}