package main

type NumMatrix struct {
    prefixSum [][]int
}

func Constructor(matrix [][]int) NumMatrix {
    m := len(matrix)
    if m == 0 {
        return NumMatrix{}
    }
    n := len(matrix[0])
    prefixSum := make([][]int, m+1)
    for i := range prefixSum {
        prefixSum[i] = make([]int, n+1)
    }
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            prefixSum[i+1][j+1] = matrix[i][j] + prefixSum[i][j+1] + prefixSum[i+1][j] - prefixSum[i][j]
        }
    }
    return NumMatrix{prefixSum}
}

func (this *NumMatrix) SumRegion(row1 int, col1 int, row2 int, col2 int) int {
    return this.prefixSum[row2+1][col2+1] - this.prefixSum[row1][col2+1] - this.prefixSum[row2+1][col1] + this.prefixSum[row1][col1]
}