func countOfPairs(n int, x int, y int) []int {
    if x > y {
        x, y = y, x
    }
    res := make([]int, n)
    for i := 1; i <= n; i++ {
        for j := i + 1; j <= n; j++ {
            d := j - i
            d = min(d, abs(i-x)+1+abs(j-y))
            res[d-1] += 2
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}