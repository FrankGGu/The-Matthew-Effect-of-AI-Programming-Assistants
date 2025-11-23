func numSubmatrixSumTarget(matrix [][]int, target int) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }

    rows, cols := len(matrix), len(matrix[0])
    for i := 0; i < rows; i++ {
        for j := 1; j < cols; j++ {
            matrix[i][j] += matrix[i][j-1]
        }
    }

    count := 0
    for left := 0; left < cols; left++ {
        for right := left; right < cols; right++ {
            sumCount := map[int]int{0: 1}
            currentSum := 0
            for row := 0; row < rows; row++ {
                currentSum += matrix[row][right]
                if left > 0 {
                    currentSum -= matrix[row][left-1]
                }
                count += sumCount[currentSum-target]
                sumCount[currentSum]++
            }
        }
    }

    return count
}