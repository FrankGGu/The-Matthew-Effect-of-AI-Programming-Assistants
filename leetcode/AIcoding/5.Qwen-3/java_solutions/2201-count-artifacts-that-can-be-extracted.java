public class Solution {

import java.util.*;

public class Solution {
    public int countArtifacts(int n, int[][] artifacts, int[][] queries) {
        int[][] grid = new int[n][n];
        for (int[] art : artifacts) {
            int x1 = art[0], y1 = art[1], x2 = art[2], y2 = art[3];
            for (int i = x1; i <= x2; i++) {
                for (int j = y1; j <= y2; j++) {
                    grid[i][j]++;
                }
            }
        }
        int result = 0;
        for (int[] q : queries) {
            int x = q[0], y = q[1];
            if (grid[x][y] > 0) {
                result++;
            }
        }
        return result;
    }
}
}