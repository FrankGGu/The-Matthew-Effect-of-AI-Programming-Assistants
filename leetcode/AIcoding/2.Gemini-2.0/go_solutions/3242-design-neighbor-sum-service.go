type NeighborSum struct {
    matrix [][]int
}

func Constructor(matrix [][]int) NeighborSum {
    return NeighborSum{matrix: matrix}
}

func (this *NeighborSum) Update(row int, col int, val int)  {
    this.matrix[row][col] = val
}

func (this *NeighborSum) GetSum(row int, col int) int {
    sum := 0
    for i := row - 1; i <= row + 1; i++ {
        for j := col - 1; j <= col + 1; j++ {
            if i >= 0 && i < len(this.matrix) && j >= 0 && j < len(this.matrix[0]) {
                sum += this.matrix[i][j]
            }
        }
    }
    return sum
}