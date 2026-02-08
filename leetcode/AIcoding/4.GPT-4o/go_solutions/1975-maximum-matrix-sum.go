func maxMatrixSum(matrix [][]int) int {
    totalSum := 0
    minAbsValue := math.MaxInt32
    negativeCount := 0

    for _, row := range matrix {
        for _, value := range row {
            totalSum += abs(value)
            if value < 0 {
                negativeCount++
            }
            if abs(value) < minAbsValue {
                minAbsValue = abs(value)
            }
        }
    }

    if negativeCount % 2 == 0 {
        return totalSum
    }
    return totalSum - 2*minAbsValue
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}