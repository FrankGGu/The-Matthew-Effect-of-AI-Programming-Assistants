func flipAndInvertImage(A [][]int) [][]int {
    for i := range A {
        n := len(A[i])
        for j := 0; j < (n+1)/2; j++ {
            A[i][j], A[i][n-j-1] = A[i][n-j-1]^1, A[i][j]^1
        }
    }
    return A
}