class Solution {
    public int maxAlloys(int[] metals, int[] amounts, int[][] recipes) {
        int n = recipes.length;
        int m = metals.length;
        int maxAlloys = 0;
        int[] dp = new int[5001];

        dp[0] = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            int[] recipe = recipes[i];
            int minAlloys = Integer.MAX_VALUE;
            for (int j = 0; j < m; j++) {
                if (recipe[j] > 0) {
                    minAlloys = Math.min(minAlloys, amounts[j] / recipe[j]);
                }
            }
            for (int j = 5000; j >= minAlloys; j--) {
                dp[j] = Math.max(dp[j], dp[j - minAlloys] + 1);
            }
        }

        for (int i = 5000; i >= 0; i--) {
            if (dp[i] > 0) {
                maxAlloys = Math.max(maxAlloys, i);
            }
        }

        return maxAlloys;
    }
}