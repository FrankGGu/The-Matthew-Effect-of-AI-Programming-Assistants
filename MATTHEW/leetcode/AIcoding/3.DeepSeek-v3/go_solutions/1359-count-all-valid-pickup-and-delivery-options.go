func countOrders(n int) int {
    const mod = 1e9 + 7
    res := 1
    for i := 1; i <= n; i++ {
        res = res * i % mod
        res = res * (2*i - 1) % mod
    }
    return res
}