func closestPrimes(left int, right int) []int {
    isPrime := func(n int) bool {
        if n < 2 {
            return false
        }
        for i := 2; i*i <= n; i++ {
            if n%i == 0 {
                return false
            }
        }
        return true
    }

    primes := []int{}
    for i := left; i <= right; i++ {
        if isPrime(i) {
            primes = append(primes, i)
        }
    }

    if len(primes) < 2 {
        return []int{-1, -1}
    }

    minDiff := int(^uint(0) >> 1)
    closestPair := []int{-1, -1}

    for i := 1; i < len(primes); i++ {
        diff := primes[i] - primes[i-1]
        if diff < minDiff {
            minDiff = diff
            closestPair = []int{primes[i-1], primes[i]}
        }
    }

    return closestPair
}