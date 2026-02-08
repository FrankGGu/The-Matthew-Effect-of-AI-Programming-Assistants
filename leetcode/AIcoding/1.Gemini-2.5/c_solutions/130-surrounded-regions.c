void dfs(char** board, int rows, int cols, int r, int c) {
    if (r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] != 'O') {
        return;
    }

    board[r][c] = 'E'; // Mark as escaped/safe

    dfs(board, rows, cols, r + 1, c);
    dfs(board, rows, cols, r - 1, c);
    dfs(board, rows, cols, r, c + 1);
    dfs(board, rows, cols, r, c - 1);
}

void solve(char** board, int boardSize, int* boardColSize) {
    if (boardSize == 0 || boardColSize == NULL || boardColSize[0] == 0) {
        return;
    }

    int rows = boardSize;
    int cols = boardColSize[0];

    // Step 1: Mark 'O's on the border and their connected 'O's as 'E'
    // First and last columns
    for (int r = 0; r < rows; r++) {
        if (board[r][0] == 'O') {
            dfs(board, rows, cols, r, 0);
        }
        if (board[r][cols - 1] == 'O') {
            dfs(board, rows, cols, r, cols - 1);
        }
    }

    // First and last rows
    for (int c = 0; c < cols; c++) {
        if (board[0][c] == 'O') {
            dfs(board, rows, cols, 0, c);
        }
        if (board[rows - 1][c] == 'O') {
            dfs(board, rows, cols, rows - 1, c);
        }
    }

    // Step 2: Iterate through the board
    // If 'O', change to 'X' (surrounded)
    // If 'E', change back to 'O' (escaped/safe)
    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            if (board[r][c] == 'O') {
                board[r][c] = 'X';
            } else if (board[r][c] == 'E') {
                board[r][c] = 'O';
            }
        }
    }
}