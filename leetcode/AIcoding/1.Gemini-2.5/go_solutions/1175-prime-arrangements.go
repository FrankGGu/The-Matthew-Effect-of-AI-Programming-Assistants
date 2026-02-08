const MOD = 1e9 + 7

func isPrime(num int) bool {
    if num <= 1 {
        return false
    }
    if num <= 3 {
        return true
    }
    if num%2 == 0 || num%3 == 0 {
        return false
    }
    for i := 5; i*i <= num; i = i + 6 {
        if num%i == 0 || num%(i+2) == 0 {
            return false
        }
    }
    return true
}

func factorial(k int) int {
    res := 1
    for i := 2; i <= k; i++ {
        res = (res * i) % MOD
    }
    return res
}

func numPrimeArrangements(n int) int {
    primeCount := 0
    for i := 1; i <= n; i++ {
        if isPrime(i) {
            primeCount++
        }
    }
    nonPrimeCount := n - primeCount

    ans := (factorial(primeCount) * factorial(nonPrimeCount)) % MOD
    return ans
}