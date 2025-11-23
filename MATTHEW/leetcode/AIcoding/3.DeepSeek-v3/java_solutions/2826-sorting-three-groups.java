class Solution {
    public int minimumOperations(List<Integer> nums) {
        int n = nums.size();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = nums.get(i);
        }

        int[][] dp = new int[n + 1][4];

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= 3; j++) {
                dp[i][j] = Integer.MAX_VALUE;
                for (int k = 1; k <= j; k++) {
                    int cost = (arr[i - 1] == j) ? 0 : 1;
                    if (dp[i - 1][k] != Integer.MAX_VALUE) {
                        dp[i][j] = Math.min(dp[i][j], dp[i - 1][k] + cost);
                    }
                }
            }
        }

        int res = Integer.MAX_VALUE;
        for (int j = 1; j <= 3; j++) {
            res = Math.min(res, dp[n][j]);
        }
        return res;
    }
}