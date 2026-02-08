var validTicTacToeState = function(board) {
    let countX = 0;
    let countO = 0;

    for (let i = 0; i < 3; i++) {
        for (let j = 0; j < 3; j++) {
            if (board[i][j] === 'X') {
                countX++;
            } else if (board[i][j] === 'O') {
                countO++;
            }
        }
    }

    const checkWin = (player) => {
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

    const xWins = checkWin('X');
    const oWins = checkWin('O');

    if (countO > countX || countX > countO + 1) {
        return false;
    }

    if (xWins && countX === countO) {
        return false;
    }

    if (oWins && countX === countO + 1) {
        return false;
    }

    return true;
};