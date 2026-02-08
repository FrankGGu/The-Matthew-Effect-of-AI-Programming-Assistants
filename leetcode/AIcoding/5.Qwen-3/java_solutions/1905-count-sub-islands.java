public class Solution {
    public int countSubIslands(int[][] grid1, int[][] grid2) {
        int rows = grid2.length;
        int cols = grid2[0].length;
        int count = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid2[i][j] == 1) {
                    if (dfs(grid1, grid2, i, j)) {
                        count++;
                    }
                }
            }
        }

        return count;
    }

    private boolean dfs(int[][] grid1, int[][] grid2, int i, int j) {
        if (i < 0 || i >= grid2.length || j < 0 || j >= grid2[0].length || grid2[i][j] != 1) {
            return true;
        }

        grid2[i][j] = 0;

        boolean isSub = true;

        isSub &= dfs(grid1, grid2, i + 1, j);
        isSub &= dfs(grid1, grid2, i - 1, j);
        isSub &= dfs(grid1, grid2, i, j + 1);
        isSub &= dfs(grid1, grid2, i, j - 1);

        return isSub && grid1[i][j] == 1;
    }
}