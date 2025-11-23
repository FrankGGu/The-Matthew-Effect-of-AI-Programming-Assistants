public class Solution {

import java.util.Arrays;

public class Solution {
    public int minimumXORSum(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int m = nums2.length;
        int[][] dp = new int[n + 1][1 << m];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }
        dp[0][0] = 0;
        for (int i = 1; i <= n; i++) {
            for (int mask = 0; mask < (1 << m); mask++) {
                for (int j = 0; j < m; j++) {
                    if ((mask & (1 << j)) != 0) {
                        int prevMask = mask ^ (1 << j);
                        dp[i][mask] = Math.min(dp[i][mask], dp[i - 1][prevMask] + (nums1[i - 1] ^ nums2[j]));
                    }
                }
            }
        }
        return dp[n][(1 << m) - 1];
    }
}
}