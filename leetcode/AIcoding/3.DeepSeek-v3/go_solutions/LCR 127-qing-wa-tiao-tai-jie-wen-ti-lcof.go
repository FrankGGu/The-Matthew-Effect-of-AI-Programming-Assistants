func numWays(n int) int {
    if n == 0 {
        return 1
    }
    if n <= 2 {
        return n
    }
    a, b := 1, 2
    for i := 3; i <= n; i++ {
        a, b = b, (a + b) % 1000000007
    }
    return b
}