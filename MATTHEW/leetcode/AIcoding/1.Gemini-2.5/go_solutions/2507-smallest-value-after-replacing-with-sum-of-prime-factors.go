func smallestValue(n int) int {
    for {
        if isPrime(n) {
            return n
        }
        n = sumPrimeFactors(n)
    }
}