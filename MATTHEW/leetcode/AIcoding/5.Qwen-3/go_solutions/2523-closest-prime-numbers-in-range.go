package main

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

    var primes []int
    for i := left; i <= right; i++ {
        if isPrime(i) {
            primes = append(primes, i)
        }
    }

    if len(primes) < 2 {
        return []int{-1, -1}
    }

    minDiff := right - left + 1
    result := []int{-1, -1}
    for i := 1; i < len(primes); i++ {
        diff := primes[i] - primes[i-1]
        if diff < minDiff {
            minDiff = diff
            result = []int{primes[i-1], primes[i]}
        }
    }

    return result
}