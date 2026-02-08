var tictactoe = function(moves) {
    const grid = Array(3).fill().map(() => Array(3).fill(''));
    for (let i = 0; i < moves.length; i++) {
        const [row, col] = moves[i];
        grid[row][col] = i % 2 === 0 ? 'A' : 'B';
    }

    const checkWinner = (player) => {
        for (let i = 0; i < 3; i++) {
            if (grid[i][0] === player && grid[i][1] === player && grid[i][2] === player) return true;
            if (grid[0][i] === player && grid[1][i] === player && grid[2][i] === player) return true;
        }
        if (grid[0][0] === player && grid[1][1] === player && grid[2][2] === player) return true;
        if (grid[0][2] === player && grid[1][1] === player && grid[2][0] === player) return true;
        return false;
    };

    if (checkWinner('A')) return 'A';
    if (checkWinner('B')) return 'B';
    return moves.length === 9 ? 'Draw' : 'Pending';
};