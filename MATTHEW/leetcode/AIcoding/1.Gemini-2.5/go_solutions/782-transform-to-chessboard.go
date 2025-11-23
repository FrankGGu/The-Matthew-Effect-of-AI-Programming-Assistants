func movesToChessboard(board [][]int) int {
    n := len(board)

    // Check condition 1: All rows must be either identical to board[0] or its complement.
    // Check condition 2: The count of 0s and 1s in any row/column must be n/2 and (n+1