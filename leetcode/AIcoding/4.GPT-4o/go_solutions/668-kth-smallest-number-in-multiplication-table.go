func findKthNumber(m int, n int, k int) int {
    left, right := 1, m*n
    for left < right {
        mid := left + (right-left)/2
        count := 0
        for i := 1; i <= m; i++ {
            count += min(mid/i, n)
        }
        if count < k {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}