class Solution {
    public int[] findBall(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[] ans = new int[n];
        for (int j = 0; j < n; j++) {
            int col = j;
            int row = 0;
            while (row < m) {
                int nextCol = col + grid[row][col];
                if (nextCol < 0 || nextCol >= n || grid[row][col] != grid[row][nextCol]) {
                    ans[j] = -1;
                    break;
                }
                col = nextCol;
                row++;
            }
            if (row == m) {
                ans[j] = col;
            }
        }
        return ans;
    }
}