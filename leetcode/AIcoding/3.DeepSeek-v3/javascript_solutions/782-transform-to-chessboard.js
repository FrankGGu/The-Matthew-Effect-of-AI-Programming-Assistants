var movesToChessboard = function(board) {
    const n = board.length;
    let rowSum = 0, colSum = 0, rowDiff = 0, colDiff = 0;

    for (let i = 0; i < n; ++i) {
        for (let j = 0; j < n; ++j) {
            if (board[0][0] ^ board[i][0] ^ board[0][j] ^ board[i][j]) return -1;
        }
    }

    for (let i = 0; i < n; ++i) {
        rowSum += board[0][i];
        colSum += board[i][0];
        rowDiff += (board[i][0] === i % 2) ? 1 : 0;
        colDiff += (board[0][i] === i % 2) ? 1 : 0;
    }

    if (rowSum !== Math.floor(n / 2) && rowSum !== Math.floor((n + 1) / 2)) return -1;
    if (colSum !== Math.floor(n / 2) && colSum !== Math.floor((n + 1) / 2)) return -1;

    if (n % 2 === 1) {
        if (rowDiff % 2 === 1) rowDiff = n - rowDiff;
        if (colDiff % 2 === 1) colDiff = n - colDiff;
    } else {
        rowDiff = Math.min(rowDiff, n - rowDiff);
        colDiff = Math.min(colDiff, n - colDiff);
    }

    return (rowDiff + colDiff) / 2;
};