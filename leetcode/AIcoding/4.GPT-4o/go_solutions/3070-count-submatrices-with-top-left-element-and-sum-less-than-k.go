func countSubmatrices(matrix [][]int, k int) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }

    rows, cols := len(matrix), len(matrix[0])
    count := 0

    for top := 0; top < rows; top++ {
        sum := make([]int, cols)
        for bottom := top; bottom < rows; bottom++ {
            for col := 0; col < cols; col++ {
                sum[col] += matrix[bottom][col]
            }

            count += countLessThanK(sum, k)
        }
    }

    return count
}

func countLessThanK(arr []int, k int) int {
    prefixSum := make([]int, len(arr)+1)
    for i := 0; i < len(arr); i++ {
        prefixSum[i+1] = prefixSum[i] + arr[i]
    }

    count := 0
    for i := 0; i < len(arr); i++ {
        for j := i + 1; j <= len(arr); j++ {
            if prefixSum[j]-prefixSum[i] < k {
                count++
            }
        }
    }

    return count
}