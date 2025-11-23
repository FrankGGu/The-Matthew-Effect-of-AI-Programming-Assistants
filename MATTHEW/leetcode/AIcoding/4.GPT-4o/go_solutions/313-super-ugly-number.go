func nthSuperUglyNumber(n int, primes []int) int {
    ugly := make([]int, n)
    ugly[0] = 1
    indices := make([]int, len(primes))
    nextMultiples := make([]int, len(primes))

    for i := 0; i < len(primes); i++ {
        nextMultiples[i] = primes[i]
    }

    for i := 1; i < n; i++ {
        minUgly := nextMultiples[0]
        for j := 1; j < len(primes); j++ {
            if nextMultiples[j] < minUgly {
                minUgly = nextMultiples[j]
            }
        }
        ugly[i] = minUgly

        for j := 0; j < len(primes); j++ {
            if nextMultiples[j] == minUgly {
                indices[j]++
                nextMultiples[j] = ugly[indices[j]] * primes[j]
            }
        }
    }
    return ugly[n-1]
}