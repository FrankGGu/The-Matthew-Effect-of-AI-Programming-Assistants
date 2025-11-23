class Solution {
    public int maxScore(int[] nums) {
        int n = nums.length;
        int[] gcdCache = new int[n * n];
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                gcdCache[i * n + j] = gcd(nums[i], nums[j]);
            }
        }

        int[] dp = new int[1 << n];
        return solve(nums, 1, 0, dp, gcdCache);
    }

    private int solve(int[] nums, int op, int mask, int[] dp, int[] gcdCache) {
        if (op > nums.length / 2) {
            return 0;
        }

        if (dp[mask] != 0) {
            return dp[mask];
        }

        int n = nums.length;
        int maxScore = 0;
        for (int i = 0; i < n; i++) {
            if ((mask & (1 << i)) == 0) {
                for (int j = i + 1; j < n; j++) {
                    if ((mask & (1 << j)) == 0) {
                        int newMask = mask | (1 << i) | (1 << j);
                        int gcdVal = (i < j) ? gcdCache[i * n + j] : gcdCache[j * n + i];
                        maxScore = Math.max(maxScore, op * gcdVal + solve(nums, op + 1, newMask, dp, gcdCache));
                    }
                }
                break;
            }
        }

        dp[mask] = maxScore;
        return maxScore;
    }

    private int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
}