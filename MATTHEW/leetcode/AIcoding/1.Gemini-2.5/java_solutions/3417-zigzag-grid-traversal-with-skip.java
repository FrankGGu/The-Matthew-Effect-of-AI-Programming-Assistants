import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> zigzagTraversalWithSkip(int[][] grid, int k) {
        List<Integer> result = new ArrayList<>();
        if (grid == null || grid.length == 0 || grid[0].length == 0) {
            return result;
        }

        int m = grid.length;
        int n = grid[0].length;
        int count = 0;

        if (k <= 0) {
            return result; 
        }

        for (int r = 0; r < m; r++) {
            if (r % 2 == 0) { // Even rows: traverse left to right
                for (int c = 0; c < n; c++) {
                    count++;
                    if (count % k == 0) {
                        result.add(grid[r][c]);
                    }
                }
            } else { // Odd rows: traverse right to left
                for (int c = n - 1; c >= 0; c--) {
                    count++;
                    if (count % k == 0) {
                        result.add(grid[r][c]);
                    }
                }
            }
        }

        return result;
    }
}