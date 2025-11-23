func maxSumSubmatrix(matrix [][]int, k int) int {
    rows := len(matrix)
    if rows == 0 {
        return 0
    }
    cols := len(matrix[0])
    maxSum := math.MinInt32

    for left := 0; left < cols; left++ {
        rowSum := make([]int, rows)
        for right := left; right < cols; right++ {
            for i := 0; i < rows; i++ {
                rowSum[i] += matrix[i][right]
            }
            currentSum := 0
            prefixSums := []int{0}
            for _, sum := range rowSum {
                currentSum += sum
                idx := sort.SearchInts(prefixSums, currentSum-k)
                if idx < len(prefixSums) {
                    candidate := currentSum - prefixSums[idx]
                    if candidate == k {
                        return k
                    }
                    if candidate > maxSum {
                        maxSum = candidate
                    }
                }
                insertPos := sort.SearchInts(prefixSums, currentSum)
                prefixSums = append(prefixSums, 0)
                copy(prefixSums[insertPos+1:], prefixSums[insertPos:])
                prefixSums[insertPos] = currentSum
            }
        }
    }
    return maxSum
}