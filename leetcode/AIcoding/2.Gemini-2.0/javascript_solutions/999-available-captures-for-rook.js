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
        if (rookRow !== -1) break;
    }

    let captures = 0;

    // Check up
    for (let i = rookRow - 1; i >= 0; i--) {
        if (board[i][rookCol] === 'p') {
            captures++;
            break;
        } else if (board[i][rookCol] === 'B') {
            break;
        }
    }

    // Check down
    for (let i = rookRow + 1; i < 8; i++) {
        if (board[i][rookCol] === 'p') {
            captures++;
            break;
        } else if (board[i][rookCol] === 'B') {
            break;
        }
    }

    // Check left
    for (let j = rookCol - 1; j >= 0; j--) {
        if (board[rookRow][j] === 'p') {
            captures++;
            break;
        } else if (board[rookRow][j] === 'B') {
            break;
        }
    }

    // Check right
    for (let j = rookCol + 1; j < 8; j++) {
        if (board[rookRow][j] === 'p') {
            captures++;
            break;
        } else if (board[rookRow][j] === 'B') {
            break;
        }
    }

    return captures;
};