public class Solution {

import java.util.*;

public class Solution {
    public int[] sumAfterQueries(int n, int[][] queries) {
        int[] result = new int[queries.length];
        int[][] matrix = new int[n][n];

        for (int i = 0; i < queries.length; i++) {
            int[] query = queries[i];
            int type = query[0];
            int x = query[1];
            int y = query[2];

            if (type == 1) {
                for (int j = 0; j < n; j++) {
                    matrix[x][j] += y;
                }
            } else if (type == 2) {
                for (int j = 0; j < n; j++) {
                    matrix[j][y] += y;
                }
            }

            int sum = 0;
            for (int[] row : matrix) {
                for (int val : row) {
                    sum += val;
                }
            }
            result[i] = sum;
        }

        return result;
    }
}
}