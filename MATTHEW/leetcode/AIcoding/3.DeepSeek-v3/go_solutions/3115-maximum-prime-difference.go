func maxPrimeDifference(nums []int) int {
    primes := make([]int, 0)
    for i, num := range nums {
        if isPrime(num) {
            primes = append(primes, i)
        }
    }
    if len(primes) < 2 {
        return 0
    }
    return primes[len(primes)-1] - primes[0]
}

func isPrime(n int) bool {
    if n <= 1 {
        return false
    }
    if n == 2 {
        return true
    }
    if n%2 == 0 {
        return false
    }
    for i := 3; i*i <= n; i += 2 {
        if n%i == 0 {
            return false
        }
    }
    return true
}