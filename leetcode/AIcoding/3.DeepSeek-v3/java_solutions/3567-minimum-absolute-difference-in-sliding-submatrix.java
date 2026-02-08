import java.util.*;

class Solution {
    public int minimumDifference(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;
        int minDiff = Integer.MAX_VALUE;

        for (int i = 0; i <= m - 2; i++) {
            for (int j = 0; j <= n - 2; j++) {
                int a = mat[i][j];
                int b = mat[i][j + 1];
                int c = mat[i + 1][j];
                int d = mat[i + 1][j + 1];
                int max = Math.max(Math.max(a, b), Math.max(c, d));
                int min = Math.min(Math.min(a, b), Math.min(c, d));
                minDiff = Math.min(minDiff, max - min);
            }
        }

        return minDiff;
    }
}