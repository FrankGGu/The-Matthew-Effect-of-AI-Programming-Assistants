func findKthNumber(m int, n int, k int) int {
    low, high := 1, m*n
    for low < high {
        mid := low + (high-low)/2
        count := 0
        for i := 1; i <= m; i++ {
            count += min(mid/i, n)
        }
        if count < k {
            low = mid + 1
        } else {
            high = mid
        }
    }
    return low
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}