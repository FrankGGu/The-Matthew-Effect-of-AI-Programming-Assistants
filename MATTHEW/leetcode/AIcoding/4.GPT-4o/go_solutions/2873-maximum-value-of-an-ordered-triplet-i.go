func maxValue(A []int) int {
    n := len(A)
    maxVal := 0
    for j := 1; j < n-1; j++ {
        maxI := 0
        for i := 0; i < j; i++ {
            if A[i] < A[j] {
                maxI = max(maxI, A[i])
            }
        }
        maxK := 0
        for k := j + 1; k < n; k++ {
            if A[k] > A[j] {
                maxK = max(maxK, A[k])
            }
        }
        if maxI > 0 && maxK > 0 {
            maxVal = max(maxVal, maxI+maxK+A[j])
        }
    }
    return maxVal
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}