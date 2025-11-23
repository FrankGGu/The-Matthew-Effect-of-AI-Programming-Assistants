func findMaxLength(nums []int) int {
	count := 0
	maxLength := 0
	m := make(map[int]int)
	m[0] = -1

	for i := 0; i < len(nums); i++ {
		if nums[i] == 0 {
			count--
		} else {
			count++
		}

		if val, ok := m[count]; ok {
			length := i - val
			if length > maxLength {
				maxLength = length
			}
		} else {
			m[count] = i
		}
	}

	return maxLength
}