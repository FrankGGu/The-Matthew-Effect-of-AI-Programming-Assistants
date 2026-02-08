var tictactoe = function(moves) {
    const board = Array(3).fill().map(() => Array(3).fill(''));

    for (let i = 0; i < moves.length; i++) {
        const [row, col] = moves[i];
        board[row][col] = i % 2 === 0 ? 'A' : 'B';
    }

    const checkWin = (player) => {
        for (let i = 0; i < 3; i++) {
            if (board[i].every(cell => cell === player) || 
                board.every(row => row[i] === player)) {
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

    if (checkWin('A')) return 'A';
    if (checkWin('B')) return 'B';
    return moves.length === 9 ? 'Draw' : 'Pending';
};