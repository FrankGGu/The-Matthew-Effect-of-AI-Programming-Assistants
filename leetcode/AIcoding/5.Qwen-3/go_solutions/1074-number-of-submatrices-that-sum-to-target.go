package main

func numSubmatrixSumTarget(target int, matrix [][]int) int {
    rows, cols := len(matrix), len(matrix[0])
    for i := 0; i < rows; i++ {
        for j := 1; j < cols; j++ {
            matrix[i][j] += matrix[i][j-1]
        }
    }

    result := 0
    for left := 0; left < cols; left++ {
        for right := left; right < cols; right++ {
            sumMap := map[int]int{0: 1}
            currentSum := 0
            for i := 0; i < rows; i++ {
                currentSum += matrix[i][right] - (matrix[i][left-1] if left > 0 else 0)
                if count, ok := sumMap[currentSum-target]; ok {
                    result += count
                }
                sumMap[currentSum]++
            }
        }
    }
    return result
}