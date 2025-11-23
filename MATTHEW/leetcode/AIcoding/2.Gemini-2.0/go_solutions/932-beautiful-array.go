func beautifulArray(n int) []int {
	if n == 1 {
		return []int{1}
	}
	odds := beautifulArray((n + 1) / 2)
	evens := beautifulArray(n / 2)
	result := make([]int, n)
	for i := 0; i < len(odds); i++ {
		result[i] = odds[i]*2 - 1
	}
	for i := 0; i < len(evens); i++ {
		result[len(odds)+i] = evens[i] * 2
	}
	return result
}