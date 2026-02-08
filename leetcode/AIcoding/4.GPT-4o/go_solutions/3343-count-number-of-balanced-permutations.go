func countBalancedPermutations(n int) int {
    mod := 1000000007
    if n%2 != 0 {
        return 0
    }
    m := n / 2
    factorial := make([]int, n+1)
    factorial[0] = 1
    for i := 1; i <= n; i++ {
        factorial[i] = factorial[i-1] * i % mod
    }
    return factorial[n] * pow(factorial[m], mod-2) % mod * pow(factorial[m], mod-2) % mod
}

func pow(x, y int) int {
    res := 1
    x = x % 1000000007
    for y > 0 {
        if y&1 == 1 {
            res = res * x % 1000000007
        }
        y = y >> 1
        x = x * x % 1000000007
    }
    return res
}