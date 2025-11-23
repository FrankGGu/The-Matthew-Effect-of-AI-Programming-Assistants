class Solution {
    public boolean splitArraySameAverage(int[] A) {
        int n = A.length, total = 0;
        for (int num : A) total += num;
        for (int k = 1; k <= n / 2; k++) {
            if (total * k % n == 0) {
                if (canSplit(A, n, total * k / n, k)) return true;
            }
        }
        return false;
    }

    private boolean canSplit(int[] A, int n, int target, int k) {
        boolean[][] dp = new boolean[k + 1][target + 1];
        dp[0][0] = true;
        for (int num : A) {
            for (int i = k; i > 0; i--) {
                for (int j = target; j >= num; j--) {
                    dp[i][j] |= dp[i - 1][j - num];
                }
            }
        }
        return dp[k][target];
    }
}