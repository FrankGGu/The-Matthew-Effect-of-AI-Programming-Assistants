class Solution {
    public int stoneGameV(int[] stoneValue) {
        int n = stoneValue.length;
        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + stoneValue[i];
        }

        Integer[][] dp = new Integer[n][n];

        return solve(stoneValue, prefixSum, 0, n - 1, dp);
    }

    private int solve(int[] stoneValue, int[] prefixSum, int left, int right, Integer[][] dp) {
        if (left == right) {
            return 0;
        }

        if (dp[left][right] != null) {
            return dp[left][right];
        }

        int maxScore = 0;
        for (int i = left; i < right; i++) {
            int leftSum = prefixSum[i + 1] - prefixSum[left];
            int rightSum = prefixSum[right + 1] - prefixSum[i + 1];

            if (leftSum < rightSum) {
                maxScore = Math.max(maxScore, leftSum + solve(stoneValue, prefixSum, left, i, dp));
            } else if (leftSum > rightSum) {
                maxScore = Math.max(maxScore, rightSum + solve(stoneValue, prefixSum, i + 1, right, dp));
            } else {
                maxScore = Math.max(maxScore, leftSum + Math.max(solve(stoneValue, prefixSum, left, i, dp), solve(stoneValue, prefixSum, i + 1, right, dp)));
            }
        }

        dp[left][right] = maxScore;
        return maxScore;
    }
}