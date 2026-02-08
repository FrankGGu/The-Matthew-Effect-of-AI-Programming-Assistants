import java.util.TreeSet;

class Solution {
    public int minDifference(int[][] grid, int x) {
        int m = grid.length;
        int n = grid[0].length;
        int ans = Integer.MAX_VALUE;
        for (int i = 0; i < m - x; i++) {
            for (int j = 0; j < n - x; j++) {
                TreeSet<Integer> set = new TreeSet<>();
                for (int row = i; row <= i + x; row++) {
                    for (int col = j; col <= j + x; col++) {
                        Integer floor = set.floor(grid[row][col]);
                        Integer ceiling = set.ceiling(grid[row][col]);
                        if (floor != null) {
                            ans = Math.min(ans, grid[row][col] - floor);
                        }
                        if (ceiling != null) {
                            ans = Math.min(ans, ceiling - grid[row][col]);
                        }
                        set.add(grid[row][col]);
                    }
                }
            }
        }
        return ans;
    }
}