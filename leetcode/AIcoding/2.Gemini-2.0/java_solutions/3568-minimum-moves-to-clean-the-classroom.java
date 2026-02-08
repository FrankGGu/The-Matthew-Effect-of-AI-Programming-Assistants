import java.util.*;

class Solution {
    private int rows;
    private int cols;

    public int minimumMoves(String[] grid) {
        rows = grid.length;
        cols = grid[0].length();

        int startRow = -1, startCol = -1;
        int endRow = -1, endCol = -1;
        List<int[]> dirtyCells = new ArrayList<>();

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i].charAt(j) == 'S') {
                    startRow = i;
                    startCol = j;
                } else if (grid[i].charAt(j) == 'E') {
                    endRow = i;
                    endCol = j;
                } else if (grid[i].charAt(j) == 'D') {
                    dirtyCells.add(new int[]{i, j});
                }
            }
        }

        int n = dirtyCells.size();
        int[][] dist = new int[n + 2][n + 2];
        for (int i = 0; i < n + 2; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
        }

        // Calculate distances from start
        dist[0][0] = 0;
        Queue<int[]> q = new LinkedList<>();
        q.offer(new int[]{startRow, startCol});
        boolean[][] visited = new boolean[rows][cols];
        visited[startRow][startCol] = true;
        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        while (!q.isEmpty()) {
            int[] curr = q.poll();
            int r = curr[0];
            int c = curr[1];

            for (int i = 0; i < n; i++) {
                int[] dirty = dirtyCells.get(i);
                if (dist(r, c, dirty[0], dirty[1]) == 1 && dist[0][i + 1] == Integer.MAX_VALUE) {
                    dist[0][i + 1] = dist[i + 1][0] = dist(startRow, startCol, r, c) + 1;
                }
            }

            for (int[] dir : directions) {
                int nr = r + dir[0];
                int nc = c + dir[1];
                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr].charAt(nc) != 'W' && !visited[nr][nc]) {
                    visited[nr][nc] = true;
                    dist[0][0] = dist(startRow, startCol, nr, nc);
                    q.offer(new int[]{nr, nc});
                }
            }
        }

        dist[0][0] = 0;

        // Calculate distances between dirty cells
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                dist[i + 1][j + 1] = dist[j + 1][i + 1] = dist(dirtyCells.get(i)[0], dirtyCells.get(i)[1], dirtyCells.get(j)[0], dirtyCells.get(j)[1]);
            }
        }

        // Calculate distances to end
        for (int i = 0; i < n; i++) {
            dist[i + 1][n + 1] = dist[n + 1][i + 1] = dist(dirtyCells.get(i)[0], dirtyCells.get(i)[1], endRow, endCol);
        }

        dist[0][n + 1] = dist[n + 1][0] = dist(startRow, startCol, endRow, endCol);

        for (int i = 0; i < n; i++) {
            if(dist[0][i+1] == Integer.MAX_VALUE){
                return -1;
            }
        }

        return solveTSP(dist);
    }

    private int dist(int r1, int c1, int r2, int c2) {
        Queue<int[]> q = new LinkedList<>();
        q.offer(new int[]{r1, c1, 0});
        boolean[][] visited = new boolean[rows][cols];
        visited[r1][c1] = true;
        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        while (!q.isEmpty()) {
            int[] curr = q.poll();
            int r = curr[0];
            int c = curr[1];
            int d = curr[2];

            if (r == r2 && c == c2) {
                return d;
            }

            for (int[] dir : directions) {
                int nr = r + dir[0];
                int nc = c + dir[1];
                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && !visited[nr][nc]) {
                    visited[nr][nc] = true;
                    q.offer(new int[]{nr, nc, d + 1});
                }
            }
        }

        return Integer.MAX_VALUE;
    }

    private int solveTSP(int[][] dist) {
        int n = dist.length;
        int[][] dp = new int[1 << n][n];
        for (int[] row : dp) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }

        dp[1][0] = 0;

        for (int mask = 1; mask < (1 << n); mask++) {
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) != 0) {
                    for (int j = 0; j < n; j++) {
                        if (i != j && (mask & (1 << j)) != 0 && dp[mask ^ (1 << i)][j] != Integer.MAX_VALUE) {
                            dp[mask][i] = Math.min(dp[mask][i], dp[mask ^ (1 << i)][j] + dist[j][i]);
                        }
                    }
                }
            }
        }

        return dp[(1 << n) - 1][n - 1];
    }
}