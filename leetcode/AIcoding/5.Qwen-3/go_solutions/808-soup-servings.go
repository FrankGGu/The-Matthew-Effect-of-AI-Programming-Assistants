package main

func soupServings(n int) float64 {
    memo := make(map[[2]int]float64)
    var dp func(a, b int) float64
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
        key := [2]int{a, b}
        if val, ok := memo[key]; ok {
            return val
        }
        res := 0.25 * (dp(a-1, b) + dp(a-2, b) + dp(a, b-1) + dp(a, b-2))
        memo[key] = res
        return res
    }
    return dp(n, n)
}