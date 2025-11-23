class Solution {
    public int maxScore(int[] nums) {
        int n = nums.length;
        int[][] gcdMatrix = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                gcdMatrix[i][j] = gcd(nums[i], nums[j]);
            }
        }
        int[] dp = new int[1 << n];
        for (int mask = 0; mask < (1 << n); mask++) {
            int cnt = Integer.bitCount(mask);
            if (cnt % 2 != 0) continue;
            int k = cnt / 2 + 1;
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) != 0) continue;
                for (int j = i + 1; j < n; j++) {
                    if ((mask & (1 << j)) != 0) continue;
                    int newMask = mask | (1 << i) | (1 << j);
                    dp[newMask] = Math.max(dp[newMask], dp[mask] + k * gcdMatrix[i][j]);
                }
            }
        }
        return dp[(1 << n) - 1];
    }

    private int gcd(int a, int b) {
        return b == 0 ? a : gcd(b, a % b);
    }
}