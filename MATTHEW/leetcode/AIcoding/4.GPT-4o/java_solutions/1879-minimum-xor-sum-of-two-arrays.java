import java.util.Arrays;

public class Solution {
    public int minimumXORSum(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int[][] dp = new int[1 << n][n + 1];
        for (int[] row : dp) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        dp[0][0] = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            int count = Integer.bitCount(mask);
            if (count > n) continue;
            for (int j = 0; j < n; j++) {
                if ((mask & (1 << j)) == 0) {
                    int newMask = mask | (1 << j);
                    dp[newMask][count + 1] = Math.min(dp[newMask][count + 1], dp[mask][count] + (nums1[count] ^ nums2[j]));
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int i = 0; i <= n; i++) {
            result = Math.min(result, dp[(1 << n) - 1][i]);
        }
        return result;
    }
}