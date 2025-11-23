function movesToChessboard(board) {
    const n = board.length;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if ((board[i][j] + board[i][0] + board[0][j] + board[0][0]) % 2 !== 0) {
                return -1;
            }
        }
    }

    let rowSwap = 0, colSwap = 0;
    for (let i = 0; i < n; i++) {
        if (board[i][0] !== (i % 2 === 0 ? 0 : 1)) rowSwap++;
        if (board[0][i] !== (i % 2 === 0 ? 0 : 1)) colSwap++;
    }

    if (n % 2 === 1) {
        if (rowSwap % 2 === 1) rowSwap = n - rowSwap;
        if (colSwap % 2 === 1) colSwap = n - colSwap;
    } else {
        rowSwap = Math.min(rowSwap, n - rowSwap);
        colSwap = Math.min(colSwap, n - colSwap);
    }

    return rowSwap + colSwap;
}