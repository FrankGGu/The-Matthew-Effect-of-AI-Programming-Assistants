class Solution {
    public int minIncrements(int[] A, int target) {
        int n = A.length;
        int[] dp = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1] + A[i - 1];
        }
        int res = Integer.MAX_VALUE;
        for (int i = 0; i <= n; i++) {
            res = Math.min(res, Math.max(0, target - dp[i]));
        }
        return res;
    }
}