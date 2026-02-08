var validTicTacToe = function(board) {
    const countX = board.flat().filter(c => c === 'X').length;
    const countO = board.flat().filter(c => c === 'O').length;

    if (countX < countO || countX > countO + 1) return false;

    const winX = checkWin('X');
    const winO = checkWin('O');

    if (winX && winO) return false;
    if (winX && countX === countO) return false;
    if (winO && countX > countO) return false;

    return true;

    function checkWin(player) {
        for (let i = 0; i < 3; i++) {
            if (board[i][0] === player && board[i][1] === player && board[i][2] === player) return true;
            if (board[0][i] === player && board[1][i] === player && board[2][i] === player) return true;
        }
        if (board[0][0] === player && board[1][1] === player && board[2][2] === player) return true;
        if (board[0][2] === player && board[1][1] === player && board[2][0] === player) return true;
        return false;
    }
};