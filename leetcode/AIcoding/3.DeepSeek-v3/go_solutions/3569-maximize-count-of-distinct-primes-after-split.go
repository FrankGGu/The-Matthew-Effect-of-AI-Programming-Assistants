func distinctPrimeFactors(nums []int) int {
    primeSet := make(map[int]bool)

    for _, num := range nums {
        factors := getPrimeFactors(num)
        for p := range factors {
            primeSet[p] = true
        }
    }

    return len(primeSet)
}

func getPrimeFactors(n int) map[int]bool {
    factors := make(map[int]bool)

    for i := 2; i*i <= n; i++ {
        for n%i == 0 {
            factors[i] = true
            n /= i
        }
    }

    if n > 1 {
        factors[n] = true
    }

    return factors
}