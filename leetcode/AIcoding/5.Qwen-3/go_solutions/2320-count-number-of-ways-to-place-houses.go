package main

func numberOfWays(n int) int {
    if n == 1 {
        return 2
    }
    a, b := 1, 2
    for i := 2; i <= n; i++ {
        a, b = b, (a + b) % (1000000007)
    }
    return b
}