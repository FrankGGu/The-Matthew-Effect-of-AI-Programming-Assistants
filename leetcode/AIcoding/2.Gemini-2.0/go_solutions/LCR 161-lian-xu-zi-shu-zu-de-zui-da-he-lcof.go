func solve() []int {
	sales := []int{3, 2, 1, 4, 5, 6, 2, 3, 4}
	k := 3
	n := len(sales)
	result := make([]int, n-k+1)

	for i := 0; i <= n-k; i++ {
		sum := 0
		for j := 0; j < k; j++ {
			sum += sales[i+j]
		}
		result[i] = sum
	}

	return result
}