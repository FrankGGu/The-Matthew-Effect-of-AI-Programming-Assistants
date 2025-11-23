func soupServings(n int) float64 {
    if n > 4800 {
        return 1.0
    }
    n = (n + 24) / 25
    memo := make(map[[2]int]float64)
    var dp func(int, int) float64
    dp = func(a, b int) float64 {
        if a <= 0 && b <= 0 {
            return 0.5
        }
        if a <= 0 {
            return 1.0
        }
        if b <= 0 {
            return 0.0
        }
        if val, ok := memo[[2]int{a, b}]; ok {
            return val
        }
        memo[[2]int{a, b}] = 0.25 * (dp(a-4, b) + dp(a-3, b-1) + dp(a-2, b-2) + dp(a-1, b-3))
        return memo[[2]int{a, b}]
    }
    return dp(n, n)
}