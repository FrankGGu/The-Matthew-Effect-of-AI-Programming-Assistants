func distinctDifferenceArray(nums []int) []int {
	n := len(nums)
	result := make([]int, n)
	for i := 0; i < n; i++ {
		prefix := nums[:i+1]
		suffix := nums[i+1:]
		distinctPrefix := make(map[int]bool)
		for _, num := range prefix {
			distinctPrefix[num] = true
		}
		distinctSuffix := make(map[int]bool)
		for _, num := range suffix {
			distinctSuffix[num] = true
		}
		result[i] = len(distinctPrefix) - len(distinctSuffix)
	}
	return result
}