func maxTriangleHeight(A []int) int {
    sort.Ints(A)
    n := len(A)
    if n < 3 {
        return 0
    }
    maxHeight := 0
    for i := 2; i < n; i++ {
        if A[i-2] + A[i-1] > A[i] {
            height := (A[i-2] + A[i-1] + A[i]) / 3
            if height > maxHeight {
                maxHeight = height
            }
        }
    }
    return maxHeight
}