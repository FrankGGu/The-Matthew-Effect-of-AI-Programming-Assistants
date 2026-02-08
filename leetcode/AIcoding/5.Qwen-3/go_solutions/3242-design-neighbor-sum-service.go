package main

type NeighborSum struct {
    grid [][]int
    rows int
    cols int
}

func Constructor(grid [][]int) NeighborSum {
    return NeighborSum{
        grid: grid,
        rows: len(grid),
        cols: len(grid[0]),
    }
}

func (this *NeighborSum) Value(i int, j int) int {
    if i < 0 || i >= this.rows || j < 0 || j >= this.cols {
        return 0
    }
    return this.grid[i][j]
}

func (this *NeighborSum) NeighboringSum(i int, j int) int {
    sum := 0
    sum += this.Value(i-1, j)
    sum += this.Value(i+1, j)
    sum += this.Value(i, j-1)
    sum += this.Value(i, j+1)
    return sum
}