int numRookCaptures(char** board, int boardSize, int* boardColSize) {
    int rookRow = -1, rookCol = -1;
    int captures = 0;

    // Find the rook's position
    for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < boardColSize[i]; j++) {
            if (board[i][j] == 'R') {
                rookRow = i;
                rookCol = j;
                break;
            }
        }
        if (rookRow != -1) {
            break;
        }
    }

    // Check up
    for (int r = rookRow - 1; r >= 0; r--) {
        if (board[r][rookCol] == 'p') {
            captures++;
            break;
        }
        if (board[r][rookCol] == 'B') {
            break;
        }
    }

    // Check down
    for (int r = rookRow + 1; r < boardSize; r++) {
        if (board[r][rookCol] == 'p') {
            captures++;
            break;
        }
        if (board[r][rookCol] == 'B') {
            break;
        }
    }

    // Check left
    for (int c = rookCol - 1; c >= 0; c--) {
        if (board[rookRow][c] == 'p') {
            captures++;
            break;
        }
        if (board[rookRow][c] == 'B') {
            break;
        }
    }

    // Check right
    for (int c = rookCol + 1; c < boardColSize[rookRow]; c++) {
        if (board[rookRow][c] == 'p') {
            captures++;
            break;
        }
        if (board[rookRow][c] == 'B') {
            break;
        }
    }

    return captures;
}