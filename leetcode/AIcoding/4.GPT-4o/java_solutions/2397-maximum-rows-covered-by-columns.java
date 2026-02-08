import java.util.*;

public class Solution {
    public int maximumRows(int[][] mat, int cols) {
        int m = mat.length, n = mat[0].length;
        int maxRows = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            if (Integer.bitCount(mask) != cols) continue;
            Set<Integer> coveredRows = new HashSet<>();
            for (int i = 0; i < m; i++) {
                boolean canCover = true;
                for (int j = 0; j < n; j++) {
                    if (mat[i][j] == 1 && ((mask >> j) & 1) == 0) {
                        canCover = false;
                        break;
                    }
                }
                if (canCover) {
                    coveredRows.add(i);
                }
            }
            maxRows = Math.max(maxRows, coveredRows.size());
        }

        return maxRows;
    }
}