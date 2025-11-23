func distinctPrimeFactors(nums []int) int {
    primeFactors := make(map[int]bool)

    for _, num := range nums {
        factors := getPrimeFactors(num)
        for factor := range factors {
            primeFactors[factor] = true
        }
    }

    return len(primeFactors)
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