import java.util.HashMap;

public class Solution {
    public int lenLongestFibSubseq(int[] A) {
        int n = A.length;
        HashMap<Integer, Integer> index = new HashMap<>();
        for (int i = 0; i < n; i++) {
            index.put(A[i], i);
        }

        int maxLen = 0;
        int[][] dp = new int[n][n];

        for (int j = 0; j < n; j++) {
            for (int i = 0; i < j; i++) {
                int k = index.getOrDefault(A[j] - A[i], -1);
                if (k >= 0 && k < i) {
                    dp[i][j] = dp[k][i] + 1;
                    maxLen = Math.max(maxLen, dp[i][j]);
                }
            }
        }

        return maxLen >= 1 ? maxLen + 2 : 0;
    }
}