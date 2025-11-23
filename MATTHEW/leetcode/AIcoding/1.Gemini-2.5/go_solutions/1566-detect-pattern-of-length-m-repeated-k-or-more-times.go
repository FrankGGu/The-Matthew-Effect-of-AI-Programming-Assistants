func containsPattern(arr []int, m int, k int) bool {
    n := len(arr)

    for i := 0; i <= n - k*m; i++ {
        numMatches := 0
        for j := 1; j < k; j++ {
            isMatch := true
            // Compare the j-th subsequent pattern with the initial pattern starting at i
            // The j-th subsequent pattern starts at index i + j*m
            // The initial pattern starts at index i
            for offset := 0; offset < m; offset++ {
                if arr[i+j*m+offset] != arr[i+offset] {
                    isMatch = false
                    break
                }
            }
            if isMatch {
                numMatches++
            } else {
                // If a pattern doesn't match, the consecutive repetition is broken
                break
            }
        }
        // If numMatches equals k-1, it means the initial pattern plus k-1 subsequent patterns
        // all matched consecutively, totaling k repetitions.
        if numMatches == k-1 {
            return true
        }
    }

    return false
}