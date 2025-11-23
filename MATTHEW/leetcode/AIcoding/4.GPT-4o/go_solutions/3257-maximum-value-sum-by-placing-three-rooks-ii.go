func maxValueSum(matrix [][]int) int {
    rows, cols := len(matrix), len(matrix[0])
    maxSum := 0

    for i1 := 0; i1 < rows; i1++ {
        for j1 := 0; j1 < cols; j1++ {
            for i2 := 0; i2 < rows; i2++ {
                for j2 := 0; j2 < cols; j2++ {
                    if i1 == i2 || j1 == j2 {
                        continue
                    }
                    for i3 := 0; i3 < rows; i3++ {
                        for j3 := 0; j3 < cols; j3++ {
                            if (i3 == i1 || i3 == i2) || (j3 == j1 || j3 == j2) {
                                continue
                            }
                            sum := matrix[i1][j1] + matrix[i2][j2] + matrix[i3][j3]
                            if sum > maxSum {
                                maxSum = sum
                            }
                        }
                    }
                }
            }
        }
    }

    return maxSum
}