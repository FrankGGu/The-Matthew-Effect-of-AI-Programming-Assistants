public class Solution {
    public int getMaxGridHappiness(int m, int n, int k) {
        int[][] grid = new int[m][n];
        return dfs(grid, 0, 0, k, 0);
    }

    private int dfs(int[][] grid, int i, int j, int k, int res) {
        if (k == 0 || i == grid.length) {
            return res;
        }
        int ni = i, nj = j + 1;
        if (nj == grid[0].length) {
            ni++;
            nj = 0;
        }
        int max = dfs(grid, ni, nj, k, res);
        int val = 0;
        for (int di = -1; di <= 1; di++) {
            for (int dj = -1; dj <= 1; dj++) {
                if (di == 0 && dj == 0) continue;
                int ni2 = i + di;
                int nj2 = j + dj;
                if (ni2 >= 0 && ni2 < grid.length && nj2 >= 0 && nj2 < grid[0].length) {
                    if (grid[ni2][nj2] == 1) {
                        val += 2;
                    }
                }
            }
        }
        grid[i][j] = 1;
        max = Math.max(max, dfs(grid, ni, nj, k - 1, res + 2 + val));
        grid[i][j] = 0;
        return max;
    }
}