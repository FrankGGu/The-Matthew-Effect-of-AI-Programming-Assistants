func numOfWays(n int) int {
    mod := 1000000007
    if n == 1 {
        return 12
    }
    a, b := 6, 6
    for i := 2; i <= n; i++ {
        a, b = b, (b*3+2*a)%mod
    }
    return b
}