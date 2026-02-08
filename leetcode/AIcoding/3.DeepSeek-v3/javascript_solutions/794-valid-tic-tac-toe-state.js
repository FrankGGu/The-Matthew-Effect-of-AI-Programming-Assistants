var validTicTacToe = function(board) {
    let xCount = 0, oCount = 0;
    for (let row of board) {
        for (let c of row) {
            if (c === 'X') xCount++;
            if (c === 'O') oCount++;
        }
    }

    if (oCount !== xCount && oCount !== xCount - 1) return false;

    const isWin = (player) => {
        for (let i = 0; i < 3; i++) {
            if (board[i][0] === player && board[i][1] === player && board[i][2] === player) return true;
            if (board[0][i] === player && board[1][i] === player && board[2][i] === player) return true;
        }
        if (board[0][0] === player && board[1][1] === player && board[2][2] === player) return true;
        if (board[0][2] === player && board[1][1] === player && board[2][0] === player) return true;
        return false;
    };

    const xWin = isWin('X');
    const oWin = isWin('O');

    if (xWin && oWin) return false;
    if (xWin && xCount !== oCount + 1) return false;
    if (oWin && oCount !== xCount) return false;

    return true;
};