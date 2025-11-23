import java.util.*;

public class Solution {
    public int[] maxSumQueries(int[] A, int[] B, int[][] queries) {
        int n = A.length;
        int m = queries.length;
        int[] result = new int[m];

        List<int[]> pairs = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            pairs.add(new int[]{A[i], B[i]});
        }
        pairs.sort((a, b) -> a[1] - b[1]);

        int[] prefixSums = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            prefixSums[i] = prefixSums[i - 1] + pairs.get(i - 1)[0];
        }

        for (int i = 0; i < m; i++) {
            int x = queries[i][0];
            int y = queries[i][1];
            int sum = 0;
            for (int[] pair : pairs) {
                if (pair[1] <= y) {
                    sum += pair[0];
                } else {
                    break;
                }
            }
            result[i] = sum;
        }

        return result;
    }
}