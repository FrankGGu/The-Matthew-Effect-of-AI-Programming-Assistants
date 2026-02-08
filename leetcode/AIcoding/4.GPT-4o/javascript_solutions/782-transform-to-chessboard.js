var movesToChessboard = function(board) {
    const n = board.length;
    let rowSum = 0, colSum = 0, rowSwap = 0, colSwap = 0;

    for (let i = 0; i < n; i++) {
        rowSum += board[0][i];
        colSum += board[i][0];
        if (board[i][0] === board[i ^ 1][0]) return -1;
        if (board[0][i] === board[0][i ^ 1]) rowSwap++;
        if (board[i][0] === board[i ^ 1][0]) colSwap++;
    }

    if (rowSum !== n / 2 && rowSum !== (n + 1) / 2) return -1;
    if (colSum !== n / 2 && colSum !== (n + 1) / 2) return -1;

    if (n % 2 === 0) return rowSwap / 2 + colSwap / 2;
    return Math.min(rowSwap, n - rowSwap) + Math.min(colSwap, n - colSwap);
};