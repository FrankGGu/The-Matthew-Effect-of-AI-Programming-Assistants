func constructArray(n int, k int) []int {
    result := make([]int, n)
    for i := 0; i < n; i++ {
        if i%2 == 0 {
            result[i] = (i / 2) + 1
        } else {
            if k > 0 {
                result[i] = n - (k--/2)
            } else {
                result[i] = (i / 2) + 1
            }
        }
    }
    for i := 0; i < k; i++ {
        if i%2 == 0 {
            result[n-1-i/2] = n - (i / 2) - 1
        } else {
            result[n-1-i/2] = (i / 2) + 1
        }
    }
    return result
}