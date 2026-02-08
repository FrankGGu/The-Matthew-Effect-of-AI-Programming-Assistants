func nthUglyNumber(n int) int {
    ugly := make([]int, n)
    ugly[0] = 1
    i2, i3, i5 := 0, 0, 0
    next2, next3, next5 := 2, 3, 5

    for i := 1; i < n; i++ {
        next := min(next2, min(next3, next5))
        ugly[i] = next

        if next == next2 {
            i2++
            next2 = ugly[i2] * 2
        }
        if next == next3 {
            i3++
            next3 = ugly[i3] * 3
        }
        if next == next5 {
            i5++
            next5 = ugly[i5] * 5
        }
    }
    return ugly[n-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}