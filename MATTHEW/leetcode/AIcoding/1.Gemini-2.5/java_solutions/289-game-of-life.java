class Solution {
    public void gameOfLife(int[][] board) {
        if (board == null || board.length == 0 || board[0].length == 0) {
            return;
        }

        int m = board.length;
        int n = board[0].length;

        // Define all 8 possible neighbor directions
        int[] dx = {-1, -1, -1, 0, 0, 1, 1, 1};
        int[] dy = {-1, 0, 1, -1, 1, -1, 0, 1};

        // First pass: Iterate through each cell to determine its next state
        // Use temporary states to store information about the next generation:
        // 0: Dead (current) -> Dead (next)
        // 1: Live (current) -> Live (next)
        // 2: Live (current) -> Dead (next) (was 1, will become 0)
        // 3: Dead (current) -> Live (next) (was 0, will become 1)
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int liveNeighbors = 0;

                // Count live neighbors for the current cell (i, j)
                for (int k = 0; k < 8; k++) {
                    int nx = i + dx[k];
                    int ny = j + dy[k];

                    // Check if the neighbor is within board boundaries
                    if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                        // A neighbor is considered live if its original state was 1.
                        // This includes cells that are currently 1 (live -> live)
                        // or 2 (live -> dead, but were live in the current generation).
                        if (board[nx][ny] == 1 || board[nx][ny] == 2) {
                            liveNeighbors++;
                        }
                    }
                }

                // Apply Game of Life rules
                if (board[i][j] == 1) { // Current cell is Live
                    if (liveNeighbors < 2 || liveNeighbors > 3) {
                        // Rule 1 (under-population) or Rule 3 (over-population): Live cell dies
                        board[i][j] = 2; // Mark as Live -> Dead
                    }
                    // Rule 2 (lives on): Live cell remains 1 (Live -> Live)
                } else { // Current cell is Dead (board[i][j] == 0)
                    if (liveNeighbors == 3) {
                        // Rule 4 (reproduction): Dead cell becomes live
                        board[i][j] = 3; // Mark as Dead -> Live
                    }
                    // Dead cell remains 0 (Dead -> Dead)
                }
            }
        }

        // Second pass: Update the board to its final states based on temporary marks
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i][j] == 2) { // Was Live, now Dead
                    board[i][j] = 0;
                } else if (board[i][j] == 3) { // Was Dead, now Live
                    board[i][j] = 1;
                }
            }
        }
    }
}