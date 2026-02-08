class Solution {
    private int m;
    private int n;
    private char[][] board;

    private final int[] dr = {-1, -1, -1, 0, 0, 1, 1, 1};
    private final int[] dc = {-1, 0, 1, -1, 1, -1, 0, 1};

    public int flipChess(String[] boardStr) {
        m = boardStr.length;
        n = boardStr[0].length();
        board = new char[m][n];
        for (int i = 0; i < m; i++) {
            board[i] = boardStr[i].toCharArray();
        }

        int maxFlips = 0;

        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                if (board[r][c] == '.') {
                    // Try placing 'W'
                    maxFlips = Math.max(maxFlips, calculateFlips(r, c, 'W'));
                    // Try placing 'B'
                    maxFlips = Math.max(maxFlips, calculateFlips(r, c, 'B'));
                }
            }
        }

        return maxFlips;
    }

    private int calculateFlips(int r, int c, char playerColor) {
        char opponentColor = (playerColor == 'W' ? 'B' : 'W');
        int totalFlips = 0;

        // Temporarily place the piece to simulate the board state for checking flips
        // The new piece at (r,c) acts as an anchor for flips.
        // We restore it to '.' afterwards.
        board[r][c] = playerColor; 

        for (int i = 0; i < 8; i++) {
            int currentFlipsInDirection = 0;
            int nr = r + dr[i];
            int nc = c + dc[i];

            while (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                if (board[nr][nc] == opponentColor) {
                    currentFlipsInDirection++;
                    nr += dr[i];
                    nc += dc[i];
                } else if (board[nr][nc] == playerColor) {
                    // Found our own color after a sequence of opponent's pieces
                    totalFlips += currentFlipsInDirection;
                    break; // Stop checking in this direction
                } else { // board[nr][nc] == '.' or out of bounds before finding playerColor
                    break; // Path broken, no flips in this direction
                }
            }
        }

        // Restore the cell to empty for other potential placements
        board[r][c] = '.'; 

        return totalFlips;
    }
}