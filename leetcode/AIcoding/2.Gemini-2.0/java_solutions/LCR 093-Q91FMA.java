import java.util.HashMap;
import java.util.Map;

class Solution {
    public int lenLongestFibSubseq(int[] arr) {
        int n = arr.length;
        Map<Integer, Integer> index = new HashMap<>();
        for (int i = 0; i < n; i++) {
            index.put(arr[i], i);
        }

        int[][] dp = new int[n][n];
        int maxLen = 0;

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int prev = arr[j] - arr[i];
                if (prev < arr[i] && index.containsKey(prev)) {
                    int k = index.get(prev);
                    dp[i][j] = dp[k][i] + 1;
                    maxLen = Math.max(maxLen, dp[i][j] + 2);
                }
            }
        }

        return maxLen;
    }
}