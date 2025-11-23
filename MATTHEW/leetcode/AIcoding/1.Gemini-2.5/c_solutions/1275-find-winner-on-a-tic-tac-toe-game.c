char * tictactoe(int** moves, int movesSize, int* movesColSize){
    int board[3][3] = {0}; // 0 for empty, 1 for Player A, -1 for Player B

    for (int i = 0; i < movesSize; i++) {
        int r = moves[i][0];
        int c = moves[i][1];

        if (i % 2 == 0) { // Player A's turn (X)
            board[r][c] = 1;
        } else { // Player B's turn (O)
            board[r][c] = -1;
        }

        // Check for a winner only if at least 5 moves have been made
        // (A needs 3 marks, B needs 3 marks. Min moves for A to win is 5, B to win is 6)
        if (i >= 4) {
            // Check rows
            for (int row = 0; row < 3; row++) {
                int sum = board[row][0] + board[row][1] + board[row][2];
                if (sum == 3) return "A";
                if (sum == -3) return "B";
            }

            // Check columns
            for (int col = 0; col < 3; col++) {
                int sum = board[0][col] + board[1][col] + board[2][col];
                if (sum == 3) return "A";
                if (sum == -3) return "B";
            }

            // Check diagonals
            int diag1_sum = board[0][0] + board[1][1] + board[2][2];
            if (diag1_sum == 3) return "A";
            if (diag1_sum == -3) return "B";

            int diag2_sum = board[0][2] + board[1][1] + board[2][0];
            if (diag2_sum == 3) return "A";
            if (diag2_sum == -3) return "B";
        }
    }

    // If no winner is found after all moves
    if (movesSize == 9) {
        return "Draw";
    } else {
        return "Pending";
    }
}