class Solution {
    public int numRookCaptures(char[][] board) {
        int rookRow = -1;
        int rookCol = -1;

        // Find the rook's position
        for (int i = 0; i < 8; i++) {
            for (int j = 0; j < 8; j++) {
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

        int captures = 0;

        // Define directions: up, down, left, right
        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        for (int[] dir : directions) {
            int dr = dir[0];
            int dc = dir[1];

            int currentRow = rookRow + dr;
            int currentCol = rookCol + dc;

            while (currentRow >= 0 && currentRow < 8 && currentCol >= 0 && currentCol < 8) {
                if (board[currentRow][currentCol] == 'p') {
                    captures++;
                    break; // Captured a pawn, stop in this direction
                } else if (board[currentRow][currentCol] == 'B') {
                    break; // Blocked by a bishop, stop in this direction
                }
                // If it's '.', continue in the same direction
                currentRow += dr;
                currentCol += dc;
            }
        }

        return captures;
    }
}