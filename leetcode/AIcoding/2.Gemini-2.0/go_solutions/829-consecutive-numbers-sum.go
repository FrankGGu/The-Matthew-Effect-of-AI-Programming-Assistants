func consecutiveNumbersSum(n int) int {
	count := 0
	for k := 1; k*k <= 2*n; k++ {
		if (n-k*(k-1)/2)%k == 0 && (n-k*(k-1)/2)/k > 0 {
			count++
		}
	}
	return count
}