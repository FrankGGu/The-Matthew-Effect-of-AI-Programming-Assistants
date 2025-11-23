package main

func minTotalDistanceToAllPieces(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    var rowIndices, colIndices []int

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 1 {
                rowIndices = append(rowIndices, i)
                colIndices = append(colIndices, j)
            }
        }
    }

    sort.Ints(rowIndices)
    sort.Ints(colIndices)

    total := 0
    for i := 0; i < len(rowIndices); i++ {
        total += abs(rowIndices[i] - rowIndices[len(rowIndices)/2])
    }

    for i := 0; i < len(colIndices); i++ {
        total += abs(colIndices[i] - colIndices[len(colIndices)/2])
    }

    return total
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}