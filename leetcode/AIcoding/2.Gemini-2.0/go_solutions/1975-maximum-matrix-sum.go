func maxMatrixSum(matrix [][]int) int {
    sum := 0
    negCount := 0
    minAbs := 100001
    for i := 0; i < len(matrix); i++ {
        for j := 0; j < len(matrix[0]); j++ {
            if matrix[i][j] < 0 {
                negCount++
            }
            absVal := abs(matrix[i][j])
            sum += absVal
            if absVal < minAbs {
                minAbs = absVal
            }
        }
    }
    if negCount%2 == 0 {
        return sum
    } else {
        return sum - 2*minAbs
    }
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}