class Solution {
    public int numRookCaptures(char[][] board) {
        int rookRow = -1, rookCol = -1;
        for (int i = 0; i < 8; i++) {
            for (int j = 0; j < 8; j++) {
                if (board[i][j] == 'R') {
                    rookRow = i;
                    rookCol = j;
                    break;
                }
            }
        }

        int captures = 0;

        // Check up
        for (int i = rookRow - 1; i >= 0; i--) {
            if (board[i][rookCol] == 'p') {
                captures++;
                break;
            } else if (board[i][rookCol] == 'B') {
                break;
            }
        }

        // Check down
        for (int i = rookRow + 1; i < 8; i++) {
            if (board[i][rookCol] == 'p') {
                captures++;
                break;
            } else if (board[i][rookCol] == 'B') {
                break;
            }
        }

        // Check left
        for (int j = rookCol - 1; j >= 0; j--) {
            if (board[rookRow][j] == 'p') {
                captures++;
                break;
            } else if (board[rookRow][j] == 'B') {
                break;
            }
        }

        // Check right
        for (int j = rookCol + 1; j < 8; j++) {
            if (board[rookRow][j] == 'p') {
                captures++;
                break;
            } else if (board[rookRow][j] == 'B') {
                break;
            }
        }

        return captures;
    }
}