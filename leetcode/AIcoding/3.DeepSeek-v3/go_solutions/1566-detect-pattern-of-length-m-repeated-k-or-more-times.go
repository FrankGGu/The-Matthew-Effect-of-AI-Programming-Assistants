func containsPattern(arr []int, m int, k int) bool {
    n := len(arr)
    for i := 0; i <= n-m*k; i++ {
        match := true
        for j := i + m; j < i+m*k; j++ {
            if arr[j] != arr[j-m] {
                match = false
                break
            }
        }
        if match {
            return true
        }
    }
    return false
}