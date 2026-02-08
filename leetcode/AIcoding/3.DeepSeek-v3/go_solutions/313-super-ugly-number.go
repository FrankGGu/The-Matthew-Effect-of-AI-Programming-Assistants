func nthSuperUglyNumber(n int, primes []int) int {
    ugly := make([]int, n)
    ugly[0] = 1
    pointers := make([]int, len(primes))

    for i := 1; i < n; i++ {
        minVal := math.MaxInt32
        for j := 0; j < len(primes); j++ {
            if primes[j] * ugly[pointers[j]] < minVal {
                minVal = primes[j] * ugly[pointers[j]]
            }
        }
        ugly[i] = minVal

        for j := 0; j < len(primes); j++ {
            if primes[j] * ugly[pointers[j]] == minVal {
                pointers[j]++
            }
        }
    }

    return ugly[n-1]
}