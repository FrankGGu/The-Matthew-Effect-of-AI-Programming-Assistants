import java.util.Arrays;

class Solution {
    public int minimumXORSum(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int[] dp = new int[1 << n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int mask = 1; mask < (1 << n); mask++) {
            int k = Integer.bitCount(mask); 
            for (int j = 0; j < n; j++) {
                if ((mask & (1 << j)) != 0) { 
                    if (dp[mask ^ (1 << j)] != Integer.MAX_VALUE) { 
                        dp[mask] = Math.min(dp[mask], dp[mask ^ (1 << j)] + (nums1[k - 1] ^ nums2[j]));
                    }
                }
            }
        }

        return dp[(1 << n) - 1];
    }
}