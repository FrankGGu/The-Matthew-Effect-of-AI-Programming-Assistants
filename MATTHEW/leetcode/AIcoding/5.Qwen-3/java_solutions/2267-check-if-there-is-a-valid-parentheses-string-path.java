public class Solution {
    public boolean findValidPath(int[][] grid) {
        int n = grid.length;
        return dfs(grid, 0, 0, 0);
    }

    private boolean dfs(int[][] grid, int i, int j, int balance) {
        int n = grid.length;
        if (i >= n || j >= n || balance < 0) return false;
        if (i == n - 1 && j == n - 1) return balance == 0;
        int val = grid[i][j];
        if (val == 1) balance++;
        else balance--;
        return dfs(grid, i + 1, j, balance) || dfs(grid, i, j + 1, balance);
    }
}