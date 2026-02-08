func constructArray(n int, k int) []int {
	result := make([]int, n)
	for i := 0; i < n-k-1; i++ {
		result[i] = i + 1
	}
	for i := 0; i <= k; i++ {
		if (k-i)%2 == 0 {
			result[n-k-1+i] = n - (k-i)/2
		} else {
			result[n-k-1+i] = n-k-1 + (k-i)/2 + 1
		}
	}
	return result
}