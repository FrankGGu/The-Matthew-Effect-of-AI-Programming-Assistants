import java.util.Arrays;

public class Solution {
    public int longestSubsequence(int[] arr, int target) {
        Arrays.sort(arr);
        int n = arr.length;
        int[] dp = new int[n + 1];
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1];
            if (arr[i - 1] <= target) {
                dp[i] = Math.max(dp[i], dp[i - 1] + 1);
                target -= arr[i - 1];
            }
        }

        return dp[n];
    }
}