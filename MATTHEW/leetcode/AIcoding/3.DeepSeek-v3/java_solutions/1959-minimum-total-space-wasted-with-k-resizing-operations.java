class Solution {
    public int minSpaceWasted(int[] nums, int k) {
        int n = nums.length;
        int[][] dp = new int[k + 1][n];
        int[][] maxInRange = new int[n][n];
        int[][] sumInRange = new int[n][n];

        for (int i = 0; i < n; i++) {
            int max = nums[i];
            int sum = nums[i];
            maxInRange[i][i] = max;
            sumInRange[i][i] = sum;
            for (int j = i + 1; j < n; j++) {
                max = Math.max(max, nums[j]);
                sum += nums[j];
                maxInRange[i][j] = max;
                sumInRange[i][j] = sum;
            }
        }

        for (int i = 0; i < n; i++) {
            dp[0][i] = maxInRange[0][i] * (i + 1) - sumInRange[0][i];
        }

        for (int resizes = 1; resizes <= k; resizes++) {
            for (int i = 0; i < n; i++) {
                int min = Integer.MAX_VALUE;
                for (int j = 0; j < i; j++) {
                    int current = dp[resizes - 1][j] + (maxInRange[j + 1][i] * (i - j)) - sumInRange[j + 1][i];
                    min = Math.min(min, current);
                }
                dp[resizes][i] = min;
            }
        }

        return dp[k][n - 1];
    }
}