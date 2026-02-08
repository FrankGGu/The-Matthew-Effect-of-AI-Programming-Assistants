func containsPattern(arr []int, m int, k int) bool {
    n := len(arr)
    if n < m*k {
        return false
    }
    for i := 0; i <= n-m*k; i++ {
        count := 0
        for j := 0; j < k; j++ {
            if i+j*m+m <= n && equal(arr[i:i+m], arr[i+j*m:i+j*m+m]) {
                count++
            } else {
                break
            }
        }
        if count >= k {
            return true
        }
    }
    return false
}

func equal(a []int, b []int) bool {
    for i := range a {
        if a[i] != b[i] {
            return false
        }
    }
    return true
}