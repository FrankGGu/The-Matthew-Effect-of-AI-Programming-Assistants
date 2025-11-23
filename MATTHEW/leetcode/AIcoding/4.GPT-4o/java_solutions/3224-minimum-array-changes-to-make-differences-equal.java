class Solution {
    public int minChanges(int[] nums, int k) {
        int n = nums.length;
        int[][] dp = new int[k][101];
        for (int[] row : dp) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        for (int i = 0; i < k; i++) {
            dp[i][0] = 0;
        }
        for (int i = 0; i < n; i++) {
            int modIndex = i % k;
            int[][] newDp = new int[k][101];
            for (int j = 0; j < 101; j++) {
                newDp[modIndex][j] = dp[modIndex][j];
            }
            for (int j = 0; j < k; j++) {
                for (int value = 0; value < 101; value++) {
                    if (dp[j][value] != Integer.MAX_VALUE) {
                        newDp[j][value] = Math.min(newDp[j][value], dp[j][value] + (nums[i] != value ? 1 : 0));
                        if (j + 1 < k) {
                            newDp[j + 1][nums[i]] = Math.min(newDp[j + 1][nums[i]], dp[j][value]);
                        }
                    }
                }
            }
            dp = newDp;
        }
        int result = Integer.MAX_VALUE;
        for (int j = 0; j < 101; j++) {
            result = Math.min(result, dp[(n - 1) % k][j]);
        }
        return result;
    }
}