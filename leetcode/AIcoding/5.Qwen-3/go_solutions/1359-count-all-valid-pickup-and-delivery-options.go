package main

func countOrders(n int) int {
    mod := 1000000007
    result := 1
    for i := 2; i <= n; i++ {
        result = (result * (2*i - 1) * i) % mod
    }
    return result
}