var numRookCaptures = function(board) {
    let rookRow = -1;
    let rookCol = -1;

    for (let i = 0; i < 8; i++) {
        for (let j = 0; j < 8; j++) {
            if (board[i][j] === 'R') {
                rookRow = i;
                rookCol = j;
                break;
            }
        }
        if (rookRow !== -1) {
            break;
        }
    }

    let captures = 0;

    // Check Up
    for (let r = rookRow - 1; r >= 0; r--) {
        if (board[r][rookCol] === 'p') {
            captures++;
            break;
        }
        if (board[r][rookCol] === 'B') {
            break;
        }
    }

    // Check Down
    for (let r = rookRow + 1; r < 8; r++) {
        if (board[r][rookCol] === 'p') {
            captures++;
            break;
        }
        if (board[r][rookCol] === 'B') {
            break;
        }
    }

    // Check Left
    for (let c = rookCol - 1; c >= 0; c--) {
        if (board[rookRow][c] === 'p') {
            captures++;
            break;
        }
        if (board[rookRow][c] === 'B') {
            break;
        }
    }

    // Check Right
    for (let c = rookCol + 1; c < 8; c++) {
        if (board[rookRow][c] === 'p') {
            captures++;
            break;
        }
        if (board[rookRow][c] === 'B') {
            break;
        }
    }

    return captures;
};