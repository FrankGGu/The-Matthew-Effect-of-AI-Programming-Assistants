func numPrimeArrangements(n int) int {
	isPrime := make([]bool, n+1)
	for i := 2; i <= n; i++ {
		isPrime[i] = true
	}

	for i := 2; i*i <= n; i++ {
		if isPrime[i] {
			for j := i * i; j <= n; j += i {
				isPrime[j] = false
			}
		}
	}

	primeCount := 0
	for i := 2; i <= n; i++ {
		if isPrime[i] {
			primeCount++
		}
	}

	nonPrimeCount := n - primeCount

	fact := func(x int) int {
		res := 1
		for i := 1; i <= x; i++ {
			res = (res * i) % 1000000007
		}
		return res
	}

	return (fact(primeCount) * fact(nonPrimeCount)) % 1000000007
}