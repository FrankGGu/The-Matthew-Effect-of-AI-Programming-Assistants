import java.util.*;

class Solution {
    int m, n;
    int[][] grid;
    int[][] fireTime; // Min time for fire to reach a cell
    int[] dr = {-1, 1, 0, 0};
    int[] dc = {0, 0, -1, 1};

    // Helper to check if (r, c) is within grid bounds
    boolean isValid(int r, int c) {
        return r >= 0 && r < m && c >= 0 && c < n;
    }

    // Pre-calculate fire spread times using multi-source BFS
    void calculateFireSpread() {
        fireTime = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(fireTime[i], Integer.MAX_VALUE);
        }

        Queue<int[]> q = new LinkedList<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) { // Fire source
                    q.offer(new int[]{i, j});
                    fireTime[i][j] = 0;
                }
            }
        }

        // BFS for fire spread
        while (!q.isEmpty()) {
            int[] curr = q.poll();
            int r = curr[0];
            int c = curr[1];

            for (int k = 0; k < 4; k++) {
                int nr = r + dr[k];
                int nc = c + dc[k];

                // If valid, not a wall, and fire hasn't reached it yet
                if (isValid(nr, nc) && grid[nr][nc] != 2 && fireTime[nr][nc] == Integer.MAX_VALUE) {
                    fireTime[nr][nc] = fireTime[r][c] + 1;
                    q.offer(new int[]{nr, nc});
                }
            }
        }
    }

    // Check if person can escape with a given waitTime
    boolean canEscape(int waitTime) {
        // If fire reaches (0,0) at or before the person starts moving, they can't escape
        if (fireTime[0][0] <= waitTime) {
            return false;
        }

        int[][] personDist = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(personDist[i], -1); // -1 means not visited
        }

        Queue<int[]> q = new LinkedList<>();

        // Person starts at (0,0) at time `waitTime`
        q.offer(new int[]{0, 0});
        personDist[0][0] = waitTime;

        // BFS for person's movement
        while (!q.isEmpty()) {
            int[] curr = q.poll();
            int r = curr[0];
            int c = curr[1];
            int currentTime = personDist[r][c];

            // If reached target
            if (r == m - 1 && c == n - 1) {
                return true;
            }

            for (int k = 0; k < 4; k++) {
                int nr = r + dr[k];
                int nc = c + dc[k];

                // If valid, not a wall, and not visited by person yet
                if (isValid(nr, nc) && grid[nr][nc] != 2 && personDist[nr][nc] == -1) {
                    int arrivalTimePerson = currentTime + 1;
                    int arrivalTimeFire = fireTime[nr][nc];

                    boolean safeToMove;
                    if (nr == m - 1 && nc == n - 1) { // Special condition for target cell
                        // Can arrive at same time as fire at the target
                        safeToMove = arrivalTimePerson <= arrivalTimeFire;
                    } else { // Any other cell, must arrive strictly before fire
                        safeToMove = arrivalTimePerson < arrivalTimeFire;
                    }

                    if (safeToMove) {
                        personDist[nr][nc] = arrivalTimePerson;
                        q.offer(new int[]{nr, nc});
                    }
                }
            }
        }

        return false; // Could not reach target
    }

    public int maximumMinutes(int[][] grid) {
        this.grid = grid;
        m = grid.length;
        n = grid[0].length;

        calculateFireSpread();

        int low = 0;
        int high = 1_000_000_000; // Max possible wait time as per problem constraints
        int ans = -1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (canEscape(mid)) {
                ans = mid;
                low = mid + 1; // Try to wait longer
            } else {
                high = mid - 1; // Must wait less
            }
        }

        return ans;
    }
}