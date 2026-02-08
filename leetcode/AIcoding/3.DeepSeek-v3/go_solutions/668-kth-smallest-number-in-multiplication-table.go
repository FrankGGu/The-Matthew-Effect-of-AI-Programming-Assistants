func findKthNumber(m int, n int, k int) int {
    low, high := 1, m*n
    for low < high {
        mid := low + (high-low)/2
        count := 0
        for i := 1; i <= m; i++ {
            add := mid / i
            if add > n {
                add = n
            }
            count += add
        }
        if count < k {
            low = mid + 1
        } else {
            high = mid
        }
    }
    return low
}