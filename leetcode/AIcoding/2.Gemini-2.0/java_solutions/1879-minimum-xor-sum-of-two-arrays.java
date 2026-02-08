class Solution {
    public int minimumXORSum(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int[] dp = new int[1 << n];
        for (int i = 1; i < (1 << n); i++) {
            dp[i] = Integer.MAX_VALUE;
            int bits = Integer.bitCount(i);
            for (int j = 0; j < n; j++) {
                if ((i & (1 << j)) != 0) {
                    dp[i] = Math.min(dp[i], dp[i ^ (1 << j)] + (nums1[bits - 1] ^ nums2[j]));
                }
            }
        }
        return dp[(1 << n) - 1];
    }
}