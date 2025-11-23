func maxMatrixSum(matrix [][]int) int64 {
    sum := int64(0)
    minAbs := int64(1 << 31)
    negCount := 0

    for i := 0; i < len(matrix); i++ {
        for j := 0; j < len(matrix[0]); j++ {
            absVal := int64(matrix[i][j])
            if absVal < 0 {
                absVal = -absVal
                negCount++
            }
            sum += absVal
            if absVal < minAbs {
                minAbs = absVal
            }
        }
    }

    if negCount % 2 == 0 {
        return sum
    } else {
        return sum - 2 * minAbs
    }
}