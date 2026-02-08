package main

func binaryGap(n int) int {
    last := -1
    maxDistance := 0
    for i := 0; n > 0; i++ {
        if n&1 == 1 {
            if last != -1 {
                maxDistance = max(maxDistance, i-last)
            }
            last = i
        }
        n >>= 1
    }
    return maxDistance
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}