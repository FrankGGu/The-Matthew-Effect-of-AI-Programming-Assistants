func grayCode(n int) []int {
	if n == 0 {
		return []int{0}
	}

	result := []int{0, 1}
	for i := 2; i <= n; i++ {
		size := len(result)
		for j := size - 1; j >= 0; j-- {
			result = append(result, result[j]+(1<<(i-1)))
		}
	}

	return result
}