func countPrimes(n int) int {
    if n <= 2 {
        return 0
    }

    isPrime := make([]bool, n)
    for i := 0; i < n; i++ {
        isPrime[i] = true
    }

    isPrime[0] = false
    isPrime[1] = false

    for p := 2; p*p < n; p++ {
        if isPrime[p] {
            for multiple := p * p; multiple < n; multiple += p {
                isPrime[multiple] = false
            }
        }
    }

    count := 0
    for i := 2; i < n; i++ {
        if isPrime[i] {
            count++
        }
    }

    return count
}