func integerBreak(n int) int {
    if n == 2 {
        return 1
    }
    if n == 3 {
        return 2
    }
    if n%3 == 0 {
        return int(math.Pow(3, float64(n/3)))
    }
    if n%3 == 1 {
        return int(math.Pow(3, float64(n/3-1))) * 4
    }
    return int(math.Pow(3, float64(n/3))) * 2
}