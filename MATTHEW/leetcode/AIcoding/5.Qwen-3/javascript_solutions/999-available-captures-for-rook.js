function numRookMoves(board) {
    let count = 0;
    for (let i = 0; i < 8; i++) {
        for (let j = 0; j < 8; j++) {
            if (board[i][j] === 'r') {
                for (let k = i + 1; k < 8; k++) {
                    if (board[k][j] !== '.') {
                        count++;
                        break;
                    }
                }
                for (let k = i - 1; k >= 0; k--) {
                    if (board[k][j] !== '.') {
                        count++;
                        break;
                    }
                }
                for (let k = j + 1; k < 8; k++) {
                    if (board[i][k] !== '.') {
                        count++;
                        break;
                    }
                }
                for (let k = j - 1; k >= 0; k--) {
                    if (board[i][k] !== '.') {
                        count++;
                        break;
                    }
                }
            }
        }
    }
    return count;
}