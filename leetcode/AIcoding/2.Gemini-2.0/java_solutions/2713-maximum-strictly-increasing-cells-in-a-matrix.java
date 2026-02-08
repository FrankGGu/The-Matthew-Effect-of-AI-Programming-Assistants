import java.util.*;

class Solution {
    public int maxIncreasingCells(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;

        Map<Integer, List<int[]>> valToCells = new TreeMap<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                valToCells.computeIfAbsent(mat[i][j], k -> new ArrayList<>()).add(new int[]{i, j});
            }
        }

        int[] rowMax = new int[m];
        int[] colMax = new int[n];
        int[][] dp = new int[m][n];

        for (int val : valToCells.keySet()) {
            List<int[]> cells = valToCells.get(val);
            int[] updates = new int[cells.size()];

            for (int i = 0; i < cells.size(); i++) {
                int row = cells.get(i)[0];
                int col = cells.get(i)[1];
                updates[i] = Math.max(rowMax[row], colMax[col]) + 1;
            }

            for (int i = 0; i < cells.size(); i++) {
                int row = cells.get(i)[0];
                int col = cells.get(i)[1];
                dp[row][col] = updates[i];
                rowMax[row] = Math.max(rowMax[row], dp[row][col]);
                colMax[col] = Math.max(colMax[col], dp[row][col]);
            }
        }

        int maxVal = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                maxVal = Math.max(maxVal, dp[i][j]);
            }
        }

        return maxVal;
    }
}