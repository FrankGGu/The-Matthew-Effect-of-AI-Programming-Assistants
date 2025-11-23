import java.util.*;

public class Solution {
    public int minAbsDifference(int[][] matrix, int k) {
        int m = matrix.length, n = matrix[0].length;
        int minDiff = Integer.MAX_VALUE;
        TreeSet<Integer> set = new TreeSet<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (i > 0) {
                    for (int l = 0; l < n; l++) {
                        set.add(matrix[i - 1][l]);
                    }
                }
                set.add(matrix[i][j]);
                if (set.size() > k) {
                    set.pollFirst();
                }
                if (set.size() == k) {
                    int min = set.first();
                    int max = set.last();
                    minDiff = Math.min(minDiff, max - min);
                }
            }
            set.clear();
        }

        return minDiff;
    }
}