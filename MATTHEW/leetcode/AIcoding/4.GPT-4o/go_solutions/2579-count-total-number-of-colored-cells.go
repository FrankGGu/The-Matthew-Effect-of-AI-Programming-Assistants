func countColoredCells(n int) int {
    if n == 1 {
        return 1
    }
    return n*n + (n-1)*n
}