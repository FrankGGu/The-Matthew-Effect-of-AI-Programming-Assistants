var tictactoe = function(moves) {
    const n = 3;
    const board = Array(n).fill(null).map(() => Array(n).fill(0));

    for (let i = 0; i < moves.length; i++) {
        const row = moves[i][0];
        const col = moves[i][1];
        board[row][col] = i % 2 === 0 ? 1 : 2;
    }

    const checkWinner = (player) => {
        for (let i = 0; i < n; i++) {
            if (board[i][0] === player && board[i][1] === player && board[i][2] === player) return true;
            if (board[0][i] === player && board[1][i] === player && board[2][i] === player) return true;
        }
        if (board[0][0] === player && board[1][1] === player && board[2][2] === player) return true;
        if (board[0][2] === player && board[1][1] === player && board[2][0] === player) return true;
        return false;
    };

    if (checkWinner(1)) return "A";
    if (checkWinner(2)) return "B";
    if (moves.length === n * n) return "Draw";
    return "Pending";
};