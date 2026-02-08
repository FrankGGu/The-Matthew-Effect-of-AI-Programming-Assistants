import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int[] kWeakestRows(int[][] mat, int k) {
        List<int[]> rowStrengths = new ArrayList<>();

        for (int i = 0; i < mat.length; i++) {
            int soldierCount = 0;
            for (int j = 0; j < mat[i].length; j++) {
                if (mat[i][j] == 1) {
                    soldierCount++;
                } else {
                    break;
                }
            }
            rowStrengths.add(new int[]{soldierCount, i});
        }

        Collections.sort(rowStrengths, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else {
                return a[1] - b[1];
            }
        });

        int[] result = new int[k];
        for (int i = 0; i < k; i++) {
            result[i] = rowStrengths.get(i)[1];
        }

        return result;
    }
}