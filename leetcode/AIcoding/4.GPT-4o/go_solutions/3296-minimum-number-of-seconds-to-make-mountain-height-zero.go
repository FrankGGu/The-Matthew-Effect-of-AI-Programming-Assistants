func minimumSeconds(A []int) int {
    n := len(A)
    totalSeconds := 0
    for i := 0; i < n; i++ {
        if A[i] > 0 {
            totalSeconds += A[i] / 2
            if A[i]%2 != 0 {
                totalSeconds++
            }
        }
    }
    return totalSeconds
}