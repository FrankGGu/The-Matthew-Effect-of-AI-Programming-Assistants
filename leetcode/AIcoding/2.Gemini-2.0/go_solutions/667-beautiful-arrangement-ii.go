func constructArray(n int, k int) []int {
	result := make([]int, n)
	left := 1
	right := k + 1
	index := 0
	for left <= right {
		if k%2 == 1 {
			result[index] = left
			left++
		} else {
			result[index] = right
			right--
		}
		index++
		k--
	}
	for i := k + 2; i <= n; i++ {
		result[index] = i
		index++
	}
	return result
}