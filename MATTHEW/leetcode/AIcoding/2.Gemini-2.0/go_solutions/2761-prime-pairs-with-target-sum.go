func isPrime(n int) bool {
	if n <= 1 {
		return false
	}
	for i := 2; i*i <= n; i++ {
		if n%i == 0 {
			return false
		}
	}
	return true
}

func primePairs(n int) [][]int {
	result := [][]int{}
	for i := 2; i <= n/2; i++ {
		if isPrime(i) && isPrime(n-i) {
			result = append(result, []int{i, n - i})
		}
	}
	return result
}