import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> luckyNumbers (int[][] matrix) {
        List<Integer> luckyNumbers = new ArrayList<>();
        int m = matrix.length;
        int n = matrix[0].length;

        for (int i = 0; i < m; i++) {
            int minInRow = Integer.MAX_VALUE;
            int colIndex = -1;
            for (int j = 0; j < n; j++) {
                if (matrix[i][j] < minInRow) {
                    minInRow = matrix[i][j];
                    colIndex = j;
                }
            }

            boolean isMaxInCol = true;
            for (int k = 0; k < m; k++) {
                if (matrix[k][colIndex] > minInRow) {
                    isMaxInCol = false;
                    break;
                }
            }

            if (isMaxInCol) {
                luckyNumbers.add(minInRow);
            }
        }

        return luckyNumbers;
    }
}