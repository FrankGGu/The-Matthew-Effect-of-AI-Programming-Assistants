import java.util.*;

class Solution {
    public int maxIncreasingCells(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;
        TreeMap<Integer, List<int[]>> valueToPositions = new TreeMap<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int val = mat[i][j];
                valueToPositions.computeIfAbsent(val, k -> new ArrayList<>()).add(new int[]{i, j});
            }
        }

        int[] rowMax = new int[m];
        int[] colMax = new int[n];
        int[][] dp = new int[m][n];
        int res = 0;

        for (Map.Entry<Integer, List<int[]>> entry : valueToPositions.entrySet()) {
            List<int[]> positions = entry.getValue();
            for (int[] pos : positions) {
                int i = pos[0], j = pos[1];
                dp[i][j] = Math.max(rowMax[i], colMax[j]) + 1;
                res = Math.max(res, dp[i][j]);
            }
            for (int[] pos : positions) {
                int i = pos[0], j = pos[1];
                rowMax[i] = Math.max(rowMax[i], dp[i][j]);
                colMax[j] = Math.max(colMax[j], dp[i][j]);
            }
        }

        return res;
    }
}