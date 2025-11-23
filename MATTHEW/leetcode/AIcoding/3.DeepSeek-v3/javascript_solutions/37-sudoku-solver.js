var solveSudoku = function(board) {
    const isValid = (row, col, num) => {
        for (let i = 0; i < 9; i++) {
            if (board[row][i] === num || board[i][col] === num || 
                board[Math.floor(row / 3) * 3 + Math.floor(i / 3)][Math.floor(col / 3) * 3 + (i % 3)] === num) {
                return false;
            }
        }
        return true;
    };

    const solve = () => {
        for (let i = 0; i < 9; i++) {
            for (let j = 0; j < 9; j++) {
                if (board[i][j] === '.') {
                    for (let num = 1; num <= 9; num++) {
                        const char = num.toString();
                        if (isValid(i, j, char)) {
                            board[i][j] = char;
                            if (solve()) {
                                return true;
                            }
                            board[i][j] = '.';
                        }
                    }
                    return false;
                }
            }
        }
        return true;
    };

    solve();
};