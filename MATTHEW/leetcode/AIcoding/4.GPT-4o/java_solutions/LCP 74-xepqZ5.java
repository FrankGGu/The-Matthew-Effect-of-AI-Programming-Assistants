class Solution {
    public int strongestForce(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int maxForce = 0;

        for (int i = 0; i < m; i++) {
            int currentForce = 0;
            for (int j = 0; j < n; j++) {
                currentForce += grid[i][j];
            }
            maxForce = Math.max(maxForce, currentForce);
        }

        return maxForce;
    }
}