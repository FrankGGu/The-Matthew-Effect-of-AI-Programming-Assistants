class Solution {
    public int[][] spiralMatrixIII(int R, int C, int rStart, int cStart) {
        int[][] result = new int[R * C][2];
        int idx = 0;

        int[] dr = {0, 1, 0, -1}; // Directions: Right, Down, Left, Up
        int[] dc = {1, 0, -1, 0};

        int r = rStart;
        int c = cStart;
        int dir = 0; // 0: Right, 1: Down, 2: Left, 3: Up
        int steps = 1; // Number of steps to take in the current direction

        // Add the starting cell
        result[idx++] = new int[]{r, c};

        // Continue until all R*C cells are visited
        while (idx < R * C) {
            // Take 'steps' steps in the current direction (dir)
            for (int i = 0; i < steps; i++) {
                r += dr[dir];
                c += dc[dir];
                // Check if the current cell is within bounds
                if (r >= 0 && r < R && c >= 0 && c < C) {
                    result[idx++] = new int[]{r, c};
                }
                // If all cells are visited, break early
                if (idx == R * C) {
                    break;
                }
            }
            // If all cells are visited, break early from the outer loop
            if (idx == R * C) {
                break;
            }

            // Change direction (e.g., Right -> Down)
            dir = (dir + 1) % 4;

            // Take 'steps' steps in the new direction (dir)
            for (int i = 0; i < steps; i++) {
                r += dr[dir];
                c += dc[dir];
                // Check if the current cell is within bounds
                if (r >= 0 && r < R && c >= 0 && c < C) {
                    result[idx++] = new int[]{r, c};
                }
                // If all cells are visited, break early
                if (idx == R * C) {
                    break;
                }
            }
            // If all cells are visited, break early from the outer loop
            if (idx == R * C) {
                break;
            }

            // Change direction again (e.g., Down -> Left)
            dir = (dir + 1) % 4;

            // Increment steps for the next pair of directions (e.g., from 1 step to 2 steps)
            steps++;
        }

        return result;
    }
}