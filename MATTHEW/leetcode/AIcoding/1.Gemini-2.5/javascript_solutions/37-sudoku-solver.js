var solveSudoku = function(board) {
    function isValid(row, col, char) {
        for (let c = 0; c < 9; c++) {
            if (board[row][c] === char) {
                return false;
            }
        }

        for (let r = 0; r < 9; r++) {
            if (board[r][col] === char) {
                return false;
            }
        }

        const startRow = Math.floor(row / 3) * 3;
        const startCol = Math.floor(col / 3) * 3;
        for (let r = 0; r < 3; r++) {
            for (let c = 0; c < 3; c++) {
                if (board[startRow + r][startCol + c] === char) {
                    return false;
                }
            }
        }
        return true;
    }

    function backtrack() {
        for (let r = 0; r < 9; r++) {
            for (let c = 0; c < 9; c++) {
                if (board[r][c] === '.') {
                    for (let num = 1; num <= 9; num++) {
                        const charNum = String(num);
                        if (isValid(r, c, charNum)) {
                            board[r][c] = charNum;
                            if (backtrack()) {
                                return true;
                            }
                            board[r][c] = '.';
                        }
                    }
                    return false;
                }
            }
        }
        return true;
    }

    backtrack();
};