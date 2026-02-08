func closestPrimes(left int, right int) []int {
    if right < 2 {
        return []int{-1, -1}
    }

    sieve := make([]bool, right+1)
    for i := 2; i <= right; i++ {
        sieve[i] = true
    }

    for i := 2; i*i <= right; i++ {
        if sieve[i] {
            for j := i*i; j <= right; j += i {
                sieve[j] = false
            }
        }
    }

    primes := []int{}
    for i := left; i <= right; i++ {
        if sieve[i] {
            primes = append(primes, i)
        }
    }

    if len(primes) < 2 {
        return []int{-1, -1}
    }

    minDiff := primes[1] - primes[0]
    res := []int{primes[0], primes[1]}

    for i := 2; i < len(primes); i++ {
        diff := primes[i] - primes[i-1]
        if diff < minDiff {
            minDiff = diff
            res = []int{primes[i-1], primes[i]}
        }
    }

    return res
}