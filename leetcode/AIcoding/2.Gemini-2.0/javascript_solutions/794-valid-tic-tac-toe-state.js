var validTicTacToe = function(board) {
    let xCount = 0;
    let oCount = 0;
    for (let i = 0; i < 3; i++) {
        for (let j = 0; j < 3; j++) {
            if (board[i][j] === 'X') {
                xCount++;
            } else if (board[i][j] === 'O') {
                oCount++;
            }
        }
    }
    if (oCount > xCount || xCount - oCount > 1) {
        return false;
    }

    const isWin = (player) => {
        for (let i = 0; i < 3; i++) {
            if (board[i][0] === player && board[i][1] === player && board[i][2] === player) {
                return true;
            }
            if (board[0][i] === player && board[1][i] === player && board[2][i] === player) {
                return true;
            }
        }
        if (board[0][0] === player && board[1][1] === player && board[2][2] === player) {
            return true;
        }
        if (board[0][2] === player && board[1][1] === player && board[2][0] === player) {
            return true;
        }
        return false;
    };

    const xWin = isWin('X');
    const oWin = isWin('O');

    if (xWin && oWin) {
        return false;
    }

    if (xWin && xCount === oCount) {
        return false;
    }

    if (oWin && xCount > oCount) {
        return false;
    }

    return true;
};