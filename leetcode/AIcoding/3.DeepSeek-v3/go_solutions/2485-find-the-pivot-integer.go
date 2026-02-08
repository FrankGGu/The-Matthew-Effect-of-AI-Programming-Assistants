func pivotInteger(n int) int {
    totalSum := n * (n + 1) / 2
    leftSum := 0
    for x := 1; x <= n; x++ {
        leftSum += x
        rightSum := totalSum - leftSum + x
        if leftSum == rightSum {
            return x
        }
    }
    return -1
}