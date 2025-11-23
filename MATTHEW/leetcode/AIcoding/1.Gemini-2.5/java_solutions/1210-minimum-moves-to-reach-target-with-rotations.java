import java.util.LinkedList;
import java.util.Queue;

class Solution {

    static class State {
        int r, c, orientation, moves; // orientation: 0 for horizontal, 1 for vertical

        State(int r, int c, int orientation, int moves) {
            this.r = r;
            this.c = c;
            this.orientation = orientation;
            this.moves = moves;
        }
    }

    public int minimumMoves(int[][] grid) {
        int N = grid.length;

        Queue<State> queue = new LinkedList<>();
        boolean[][][] visited = new boolean[N][N][2]; // [row][col][orientation]

        // Initial state: snake at (0,0) and (0,1), horizontal
        // (r,c) represents the top-left cell of the snake
        queue.offer(new State(0, 0, 0, 0));
        visited[0][0][0] = true;

        while (!queue.isEmpty()) {
            State current = queue.poll();
            int r = current.r;
            int c = current.c;
            int orientation = current.orientation;
            int moves = current.moves;

            // Check if target reached: snake at (N-1, N-2) and (N-1, N-1), horizontal
            if (r == N - 1 && c == N - 2 && orientation == 0) {
                return moves;
            }

            // Try all possible moves from current state

            // 1. Move Right
            if (orientation == 0) { // Horizontal: (r,c), (r,c+1) -> (r,c+1), (r,c+2)
                int nextC = c + 1;
                if (nextC + 1 < N && grid[r][nextC + 1] == 0 && !visited[r][nextC][0]) {
                    queue.offer(new State(r, nextC, 0, moves + 1));
                    visited[r][nextC][0] = true;
                }
            } else { // Vertical: (r,c), (r+1,c) -> (r,c+1), (r+1,c+1)
                int nextC = c + 1;
                if (nextC < N && grid[r][nextC] == 0 && grid[r + 1][nextC] == 0 && !visited[r][nextC][1]) {
                    queue.offer(new State(r, nextC, 1, moves + 1));
                    visited[r][nextC][1] = true;
                }
            }

            // 2. Move Down
            if (orientation == 0) { // Horizontal: (r,c), (r,c+1) -> (r+1,c), (r+1,c+1)
                int nextR = r + 1;
                if (nextR < N && grid[nextR][c] == 0 && grid[nextR][c + 1] == 0 && !visited[nextR][c][0]) {
                    queue.offer(new State(nextR, c, 0, moves + 1));
                    visited[nextR][c][0] = true;
                }
            } else { // Vertical: (r,c), (r+1,c) -> (r+1,c), (r+2,c)
                int nextR = r + 1;
                if (nextR + 1 < N && grid[nextR + 1][c] == 0 && !visited[nextR][c][1]) {
                    queue.offer(new State(nextR, c, 1, moves + 1));
                    visited[nextR][c][1] = true;
                }
            }

            // 3. Rotate Clockwise (Horizontal to Vertical)
            // Current: (r,c), (r,c+1). New: (r,c), (r+1,c). Pivots around (r,c).
            // Requires (r+1,c) and (r+1,c+1) to be empty.
            if (orientation == 0) {
                if (r + 1 < N && c + 1 < N && grid[r + 1][c] == 0 && grid[r + 1][c + 1] == 0 && !visited[r][c][1]) {
                    queue.offer(new State(r, c, 1, moves + 1));
                    visited[r][c][1] = true;
                }
            }

            // 4. Rotate Counter-Clockwise (Vertical to Horizontal)
            // Current: (r,c), (r+1,c). New: (r,c), (r,c+1). Pivots around (r,c).
            // Requires (r,c+1) and (r+1,c+1) to be empty.
            if (orientation == 1) {
                if (r + 1 < N && c + 1 < N && grid[r][c + 1] == 0 && grid[r + 1][c + 1] == 0 && !visited[r][c][0]) {
                    queue.offer(new State(r, c, 0, moves + 1));
                    visited[r][c][0] = true;
                }
            }
        }

        return -1; // Target not reachable
    }
}