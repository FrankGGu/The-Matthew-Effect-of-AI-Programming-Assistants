public class Solution {

import java.util.*;

public class Solution {
    public int[] onesMinusZeros(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[] rowOnes = new int[m];
        int[] colOnes = new int[n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    rowOnes[i]++;
                    colOnes[j]++;
                }
            }
        }

        int[] result = new int[m * n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int ones = rowOnes[i] + colOnes[j];
                int zeros = (n - rowOnes[i]) + (m - colOnes[j]);
                result[i * n + j] = ones - zeros;
            }
        }

        return result;
    }
}
}