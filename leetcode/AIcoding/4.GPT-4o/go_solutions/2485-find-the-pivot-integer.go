func pivotInteger(n int) int {
    totalSum := n * (n + 1) / 2
    for i := 1; i <= n; i++ {
        leftSum := i * (i + 1) / 2
        if leftSum == totalSum-leftSum+1 {
            return i
        }
    }
    return -1
}