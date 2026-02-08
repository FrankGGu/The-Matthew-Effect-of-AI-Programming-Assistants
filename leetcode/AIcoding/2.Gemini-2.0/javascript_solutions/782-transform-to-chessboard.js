var movesToChessboard = function(board) {
    const n = board.length;
    let rowMask = 0;
    for (let i = 0; i < n; i++) {
        rowMask |= (board[0][i] << i);
    }
    let colMask = 0;
    for (let i = 0; i < n; i++) {
        colMask |= (board[i][0] << i);
    }
    let rowMaskInv = ((1 << n) - 1) ^ rowMask;
    let colMaskInv = ((1 << n) - 1) ^ colMask;

    let rowSame = 0;
    let colSame = 0;
    for (let i = 0; i < n; i++) {
        let curRowMask = 0;
        for (let j = 0; j < n; j++) {
            curRowMask |= (board[i][j] << j);
        }
        let curColMask = 0;
        for (let j = 0; j < n; j++) {
            curColMask |= (board[j][i] << j);
        }

        if (curRowMask !== rowMask && curRowMask !== rowMaskInv) return -1;
        if (curColMask !== colMask && curColMask !== colMaskInv) return -1;

        if (curRowMask === rowMask) rowSame++;
        if (curColMask === colMask) colSame++;
    }

    if (rowSame !== Math.floor((n + 1) / 2) && rowSame !== Math.floor(n / 2)) return -1;
    if (colSame !== Math.floor((n + 1) / 2) && colSame !== Math.floor(n / 2)) return -1;

    let rowMoves = 0;
    let colMoves = 0;

    if (n % 2 === 0) {
        let rowOnes = 0;
        let colOnes = 0;
        for (let i = 0; i < n; i++) {
            if ((rowMask >> i) & 1) rowOnes++;
            if ((colMask >> i) & 1) colOnes++;
        }
        rowMoves = Math.min(rowMoves, Math.floor(n / 2) - rowOnes);
        colMoves = Math.min(colMoves, Math.floor(n / 2) - colOnes);

        let rowZeros = n - rowOnes;
        let colZeros = n - colOnes;
        rowMoves = Math.min(rowMoves, Math.floor(n / 2) - rowZeros);
        colMoves = Math.min(colMoves, Math.floor(n / 2) - colZeros);
    }

    let rowOnes = 0;
    let colOnes = 0;
    for (let i = 0; i < n; i++) {
        if ((rowMask >> i) & 1 && i % 2 === 0) rowOnes++;
        if ((colMask >> i) & 1 && i % 2 === 0) colOnes++;
    }

    rowMoves = Math.floor(n / 2) - rowOnes;
    colMoves = Math.floor(n / 2) - colOnes;

    return Math.floor((Math.abs(rowMoves) + Math.abs(colMoves)));
};