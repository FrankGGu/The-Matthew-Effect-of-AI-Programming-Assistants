public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> luckyNumbers (int[][] matrix) {
        List<Integer> result = new ArrayList<>();
        int rows = matrix.length;
        int cols = matrix[0].length;

        boolean[] isLucky = new boolean[rows];

        for (int i = 0; i < rows; i++) {
            int minVal = Integer.MAX_VALUE;
            int minCol = -1;
            for (int j = 0; j < cols; j++) {
                if (matrix[i][j] < minVal) {
                    minVal = matrix[i][j];
                    minCol = j;
                }
            }
            boolean isMax = true;
            for (int k = 0; k < rows; k++) {
                if (matrix[k][minCol] > minVal) {
                    isMax = false;
                    break;
                }
            }
            if (isMax) {
                result.add(minVal);
            }
        }

        return result;
    }
}
}