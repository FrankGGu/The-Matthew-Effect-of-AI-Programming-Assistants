func isMonotonic(A []int) bool {
    increasing, decreasing := true, true
    for i := 1; i < len(A); i++ {
        if A[i] > A[i-1] {
            decreasing = false
        }
        if A[i] < A[i-1] {
            increasing = false
        }
    }
    return increasing || decreasing
}