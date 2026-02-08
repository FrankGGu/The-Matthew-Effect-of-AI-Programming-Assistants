func countPrimes(n int) int {
	if n <= 2 {
		return 0
	}
	isPrime := make([]bool, n)
	for i := 2; i < n; i++ {
		isPrime[i] = true
	}
	count := 0
	for i := 2; i*i < n; i++ {
		if isPrime[i] {
			for j := i * i; j < n; j += i {
				isPrime[j] = false
			}
		}
	}
	for i := 2; i < n; i++ {
		if isPrime[i] {
			count++
		}
	}
	return count
}