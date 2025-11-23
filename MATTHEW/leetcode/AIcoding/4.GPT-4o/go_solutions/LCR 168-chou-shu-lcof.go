func nthUglyNumber(n int) int {
    uglyNumbers := make([]int, n)
    uglyNumbers[0] = 1
    idx2, idx3, idx5 := 0, 0, 0
    for i := 1; i < n; i++ {
        next2 := uglyNumbers[idx2] * 2
        next3 := uglyNumbers[idx3] * 3
        next5 := uglyNumbers[idx5] * 5
        nextUgly := min(next2, min(next3, next5))
        uglyNumbers[i] = nextUgly
        if nextUgly == next2 {
            idx2++
        }
        if nextUgly == next3 {
            idx3++
        }
        if nextUgly == next5 {
            idx5++
        }
    }
    return uglyNumbers[n-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}