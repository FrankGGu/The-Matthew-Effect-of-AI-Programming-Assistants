package main

func maxMatrixSum(matrix [][]int) int {
    minAbs := math.MaxInt64
    total := 0
    negativeCount := 0

    for _, row := range matrix {
        for _, val := range row {
            if val < 0 {
                negativeCount++
                total += -val
                if -val < minAbs {
                    minAbs = -val
                }
            } else {
                total += val
                if val < minAbs {
                    minAbs = val
                }
            }
        }
    }

    if negativeCount%2 == 0 {
        return total
    } else {
        return total - 2*minAbs
    }
}