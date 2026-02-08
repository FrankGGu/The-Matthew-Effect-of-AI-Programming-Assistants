func maxPriceSum(prices [][]int) int {
    n := len(prices)
    if n == 0 {
        return 0
    }
    m := len(prices[0])

    maxSum := 0
    minSum := 0

    for i := 0; i < n; i++ {
        rowMax := 0
        rowMin := math.MaxInt32
        for j := 0; j < m; j++ {
            rowMax = max(rowMax, prices[i][j])
            rowMin = min(rowMin, prices[i][j])
        }
        maxSum += rowMax
        minSum += rowMin
    }

    return maxSum - minSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}