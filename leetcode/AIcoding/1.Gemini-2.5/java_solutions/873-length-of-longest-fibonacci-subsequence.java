import java.util.HashMap;
import java.util.Map;

class Solution {
    public int lenLongestFibSubsequence(int[] arr) {
        int n = arr.length;
        Map<Integer, Integer> valToIndex = new HashMap<>();
        for (int i = 0; i < n; i++) {
            valToIndex.put(arr[i], i);
        }

        int[][] dp = new int[n][n];
        int maxLength = 0;

        for (int j = 0; j < n; j++) {
            for (int i = 0; i < j; i++) {
                dp[i][j] = 2; 

                int prevVal = arr[j] - arr[i];

                if (prevVal < arr[i] && valToIndex.containsKey(prevVal)) {
                    int p = valToIndex.get(prevVal);
                    dp[i][j] = dp[p][i] + 1;
                }
                maxLength = Math.max(maxLength, dp[i][j]);
            }
        }

        return maxLength >= 3 ? maxLength : 0;
    }
}