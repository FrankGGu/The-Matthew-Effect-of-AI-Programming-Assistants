func rearrangeArray(nums []int) []int {
	n := len(nums)
	pos := make([]int, 0, n/2)
	neg := make([]int, 0, n/2)

	for _, num := range nums {
		if num > 0 {
			pos = append(pos, num)
		} else {
			neg = append(neg, num)
		}
	}

	result := make([]int, n)
	for i := 0; i < n/2; i++ {
		result[2*i] = pos[i]
		result[2*i+1] = neg[i]
	}

	return result
}