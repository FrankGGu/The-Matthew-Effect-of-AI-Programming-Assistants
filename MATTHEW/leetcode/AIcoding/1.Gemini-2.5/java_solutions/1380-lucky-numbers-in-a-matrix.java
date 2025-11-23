import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> luckyNumbers (int[][] matrix) {
        List<Integer> luckyNumbers = new ArrayList<>();
        int rows = matrix.length;
        int cols = matrix[0].length;

        for (int i = 0; i < rows; i++) {
            int minInRow = matrix[i][0];
            int minColIndex = 0;

            for (int j = 1; j < cols; j++) {
                if (matrix[i][j] < minInRow) {
                    minInRow = matrix[i][j];
                    minColIndex = j;
                }
            }

            boolean isMaxInCol = true;
            for (int k = 0; k < rows; k++) {
                if (matrix[k][minColIndex] > minInRow) {
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