import "math/big"

func distinctPrimeFactors(nums []int) int {
    primeFactors := make(map[int]struct{})
    for _, num := range nums {
        factorize(num, primeFactors)
    }
    return len(primeFactors)
}

func factorize(n int, primeFactors map[int]struct{}) {
    for i := 2; i*i <= n; i++ {
        if n%i == 0 {
            primeFactors[i] = struct{}{}
            for n%i == 0 {
                n /= i
            }
        }
    }
    if n > 1 {
        primeFactors[n] = struct{}{}
    }
}