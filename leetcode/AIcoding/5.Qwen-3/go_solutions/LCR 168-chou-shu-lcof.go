package main

func nthUglyNumber(n int) int {
    ugly := make([]int, n)
    ugly[0] = 1
    i2, i3, i5 := 0, 0, 0
    next2, next3, next5 := 2, 3, 5
    for i := 1; i < n; i++ {
        minVal := min(next2, next3, next5)
        ugly[i] = minVal
        if minVal == next2 {
            i2++
            next2 = ugly[i2] * 2
        }
        if minVal == next3 {
            i3++
            next3 = ugly[i3] * 3
        }
        if minVal == next5 {
            i5++
            next5 = ugly[i5] * 5
        }
    }
    return ugly[n-1]
}

func min(a, b, c int) int {
    if a <= b && a <= c {
        return a
    }
    if b <= c {
        return b
    }
    return c
}