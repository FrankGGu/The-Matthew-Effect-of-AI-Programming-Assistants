import java.util.HashMap;
import java.util.Map;

class Solution {
    public int lenLongestFibSubsequence(int[] A) {
        int n = A.length;
        Map<Integer, Integer> valToIndex = new HashMap<>();
        for (int i = 0; i < n; i++) {
            valToIndex.put(A[i], i);
        }

        int[][] dp = new int[n][n];
        int maxLen = 0;

        for (int j = 0; j < n; j++) {
            for (int i = 0; i < j; i++) {
                int target = A[j] - A[i];

                if (target < A[i] && valToIndex.containsKey(target)) {
                    int k = valToIndex.get(target);

                    // If dp[k][i] is 0, it means A[k] and A[i] themselves do not form 
                    // the end of a longer Fibonacci sequence found so far.
                    // However, A[k] and A[i] form a pair of length 2.
                    // Adding A[j] makes it a Fibonacci subsequence of length 3 (A[k], A[i], A[j]).
                    // If dp[k][i] is already L (length >= 3), then A[j] extends it to L+1.
                    dp[i][j] = (dp[k][i] == 0 ? 2 : dp[k][i]) + 1;
                }

                if (dp[i][j] > maxLen) {
                    maxLen = dp[i][j];
                }
            }
        }

        return maxLen;
    }
}