package main

func maximumValueSum(board [][]int) int {
    n := len(board)
    rowMax := make([]int, n)
    colMax := make([]int, n)

    for i := 0; i < n; i++ {
        maxRow := board[i][0]
        for j := 1; j < n; j++ {
            if board[i][j] > maxRow {
                maxRow = board[i][j]
            }
        }
        rowMax[i] = maxRow
    }

    for j := 0; j < n; j++ {
        maxCol := board[0][j]
        for i := 1; i < n; i++ {
            if board[i][j] > maxCol {
                maxCol = board[i][j]
            }
        }
        colMax[j] = maxCol
    }

    sort.Ints(rowMax)
    sort.Ints(colMax)

    return rowMax[n-1] + colMax[n-1]
}