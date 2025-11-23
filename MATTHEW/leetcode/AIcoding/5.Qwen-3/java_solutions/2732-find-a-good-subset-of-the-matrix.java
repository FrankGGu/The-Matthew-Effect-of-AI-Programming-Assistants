public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> findGoodSubset(int[][] matrix) {
        int rows = matrix.length;
        int cols = matrix[0].length;
        List<List<Integer>> result = new ArrayList<>();

        for (int i = 0; i < rows; i++) {
            List<Integer> row = new ArrayList<>();
            for (int j = 0; j < cols; j++) {
                row.add(matrix[i][j]);
            }
            result.add(row);
        }

        return result;
    }
}
}