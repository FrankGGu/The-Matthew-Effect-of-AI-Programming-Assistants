func numberOfArithmeticSlices(A []int) int {
    if len(A) < 3 {
        return 0
    }
    count := 0
    current := 0
    for i := 2; i < len(A); i++ {
        if A[i] - A[i-1] == A[i-1] - A[i-2] {
            current++
            count += current
        } else {
            current = 0
        }
    }
    return count
}