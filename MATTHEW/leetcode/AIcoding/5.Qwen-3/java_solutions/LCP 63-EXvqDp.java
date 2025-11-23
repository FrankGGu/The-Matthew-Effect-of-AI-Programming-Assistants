public class Solution {

import java.util.*;

public class Solution {
    public int findBall(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[] result = new int[n];

        for (int i = 0; i < n; i++) {
            result[i] = i;
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (result[j] == -1) continue;
                int nextCol = result[j] + grid[i][result[j]];
                if (nextCol < 0 || nextCol >= n || grid[i][result[j]] != grid[i][nextCol]) {
                    result[j] = -1;
                } else {
                    result[j] = nextCol;
                }
            }
        }

        return result[0];
    }
}
}