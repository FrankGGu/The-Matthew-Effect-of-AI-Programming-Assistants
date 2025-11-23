func paintingPlan(n int, k int) int {
    if k == 0 || k == n*n {
        return 1
    }
    if k < n || k > n*n {
        return 0
    }

    res := 0
    for a := 0; a <= n; a++ {
        for b := 0; b <= n; b++ {
            if a*n + b*n - a*b == k {
                res += comb(n, a) * comb(n, b)
            }
        }
    }
    return res
}

func comb(n, k int) int {
    if k > n {
        return 0
    }
    res := 1
    for i := 1; i <= k; i++ {
        res = res * (n - k + i) / i
    }
    return res
}