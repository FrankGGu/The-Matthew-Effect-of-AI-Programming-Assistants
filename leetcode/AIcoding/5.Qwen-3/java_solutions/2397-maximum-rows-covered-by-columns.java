public class Solution {

import java.util.*;

public class Solution {
    public int maximumRowsCoveredByColumns(int[][] matrix, int[] cols) {
        int rows = matrix.length;
        int colsCount = matrix[0].length;
        Set<Integer> colSet = new HashSet<>();
        for (int col : cols) {
            colSet.add(col);
        }
        int covered = 0;
        for (int i = 0; i < rows; i++) {
            boolean allCovered = true;
            for (int j = 0; j < colsCount; j++) {
                if (matrix[i][j] == 1 && !colSet.contains(j)) {
                    allCovered = false;
                    break;
                }
            }
            if (allCovered) {
                covered++;
            }
        }
        return covered;
    }
}
}