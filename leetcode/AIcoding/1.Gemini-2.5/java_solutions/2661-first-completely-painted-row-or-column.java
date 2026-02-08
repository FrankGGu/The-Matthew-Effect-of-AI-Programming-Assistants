import java.util.HashMap;
import java.util.Map;

class Solution {
    public int firstCompleteIndex(int[][] mat, int[] arr) {
        int m = mat.length;
        int n = mat[0].length;

        Map<Integer, int[]> valToPos = new HashMap<>();
        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                valToPos.put(mat[r][c], new int[]{r, c});
            }
        }

        int[] rowCounts = new int[m];
        int[] colCounts = new int[n];

        for (int k = 0; k < arr.length; k++) {
            int val = arr[k];
            int[] pos = valToPos.get(val);
            int r = pos[0];
            int c = pos[1];

            rowCounts[r]++;
            colCounts[c]++;

            if (rowCounts[r] == n || colCounts[c] == m) {
                return k;
            }
        }

        return -1; 
    }
}