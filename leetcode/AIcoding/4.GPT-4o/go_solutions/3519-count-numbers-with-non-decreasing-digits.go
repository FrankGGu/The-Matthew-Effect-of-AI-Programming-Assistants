func countNumbersWithNonDecreasingDigits(N int) int {
    if N < 10 {
        return N + 1
    }

    digits := 1
    count := 0
    for i := 1; i < 10; i++ {
        count += 9 * combination(9, i)
    }

    for i := 1; i < digits; i++ {
        count += combination(9, i)
    }

    return count
}

func combination(n, k int) int {
    if k > n {
        return 0
    }
    if k == 0 || k == n {
        return 1
    }
    k = min(k, n-k)
    res := 1
    for i := 0; i < k; i++ {
        res *= (n - i)
        res /= (i + 1)
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}