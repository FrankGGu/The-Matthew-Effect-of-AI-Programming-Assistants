public class Solution {

import java.util.*;

public class Solution {
    public int[][] largestLocal(int[][] grid) {
        int n = grid.length;
        int[][] result = new int[n - 1][n - 1];

        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - 1; j++) {
                int max = 0;
                for (int x = i; x < i + 2; x++) {
                    for (int y = j; y < j + 2; y++) {
                        max = Math.max(max, grid[x][y]);
                    }
                }
                result[i][j] = max;
            }
        }

        return result;
    }
}
}