import java.util.*;

public class Solution {
    public List<List<Integer>> findGoodSubset(int[][] matrix) {
        List<List<Integer>> result = new ArrayList<>();
        int n = matrix.length;
        int m = matrix[0].length;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (isGoodSubset(matrix, i, j)) {
                    List<Integer> subset = new ArrayList<>();
                    subset.add(i);
                    subset.add(j);
                    result.add(subset);
                }
            }
        }
        return result;
    }

    private boolean isGoodSubset(int[][] matrix, int row, int col) {
        // Add the logic to determine if the subset is good
        // This is a placeholder for your actual condition
        return true;
    }
}