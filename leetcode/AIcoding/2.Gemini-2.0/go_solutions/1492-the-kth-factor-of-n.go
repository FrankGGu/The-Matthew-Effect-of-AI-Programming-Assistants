func kthFactor(n int, k int) int {
    factors := []int{}
    for i := 1; i*i <= n; i++ {
        if n%i == 0 {
            factors = append(factors, i)
            if i*i != n {
                factors = append(factors, n/i)
            }
        }
    }

    sort.Ints(factors)

    if k > len(factors) {
        return -1
    }

    return factors[k-1]
}

import "sort"