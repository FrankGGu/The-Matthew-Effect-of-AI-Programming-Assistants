class Solution {
    public int minimumXORSum(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int[] dp = new int[1 << n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            int k = Integer.bitCount(mask);
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) == 0) {
                    int nextMask = mask | (1 << i);
                    dp[nextMask] = Math.min(dp[nextMask], dp[mask] + (nums1[k] ^ nums2[i]));
                }
            }
        }
        return dp[(1 << n) - 1];
    }
}