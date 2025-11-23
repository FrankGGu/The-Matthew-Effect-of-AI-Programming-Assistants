func primeSetBits(L int, R int) int {
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

    count := 0
    for i := L; i <= R; i++ {
        bits := 0
        num := i
        for num > 0 {
            bits += num & 1
            num >>= 1
        }
        if isPrime(bits) {
            count++
        }
    }
    return count
}