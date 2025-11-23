func minTaps(n int, ranges []int) int {
    maxReach := make([]int, n+1)
    for i := 0; i <= n; i++ {
        left := max(0, i-ranges[i])
        right := min(n, i+ranges[i])
        maxReach[left] = max(maxReach[left], right)
    }

    taps := 0
    farthest := 0
    end := 0

    for i := 0; i < n; i++ {
        farthest = max(farthest, maxReach[i])
        if i == end {
            taps++
            end = farthest
            if end >= n {
                return taps
            }
        }
        if farthest <= i {
            return -1
        }
    }
    return taps
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}