import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> goodSubsetofBinaryMatrix(int[][] matrix) {
        int m = matrix.length;
        int n = matrix[0].length;

        for (int i = 0; i < m; i++) {
            boolean allZeros = true;
            for (int j = 0; j < n; j++) {
                if (matrix[i][j] == 1) {
                    allZeros = false;
                    break;
                }
            }
            if (allZeros) {
                List<Integer> result = new ArrayList<>();
                result.add(i);
                return result;
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = i + 1; j < m; j++) {
                boolean good = true;
                for (int k = 0; k < n; k++) {
                    if (matrix[i][k] == 1 && matrix[j][k] == 1) {
                        good = false;
                        break;
                    }
                }
                if (good) {
                    List<Integer> result = new ArrayList<>();
                    result.add(i);
                    result.add(j);
                    return result;
                }
            }
        }

        return new ArrayList<>();
    }
}