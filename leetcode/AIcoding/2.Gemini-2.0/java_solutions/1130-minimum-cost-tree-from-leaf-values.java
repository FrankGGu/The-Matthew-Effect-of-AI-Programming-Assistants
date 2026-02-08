class Solution {
    public int mctFromLeafValues(int[] arr) {
        int n = arr.length;
        int[][] dp = new int[n][n];
        int[][] maxVal = new int[n][n];

        for (int i = 0; i < n; i++) {
            maxVal[i][i] = arr[i];
        }

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                maxVal[i][j] = Math.max(arr[i], maxVal[i + 1][j]);
                for (int k = i; k < j; k++) {
                    int leftMax = 0;
                    for(int l = i; l <= k; l++) {
                        leftMax = Math.max(leftMax, arr[l]);
                    }
                    int rightMax = 0;
                    for(int l = k+1; l <= j; l++) {
                        rightMax = Math.max(rightMax, arr[l]);
                    }

                    int leftMaxVal = 0;
                    if(i<=k) {
                        leftMaxVal = maxVal[i][k];
                    }
                    int rightMaxVal = 0;
                    if(k+1<=j) {
                        rightMaxVal = maxVal[k+1][j];
                    }

                    int cost = leftMaxVal * rightMaxVal;

                    int leftCost = 0;
                    if (i <= k) {
                        leftCost = dp[i][k];
                    }
                    int rightCost = 0;
                    if (k + 1 <= j) {
                        rightCost = dp[k + 1][j];
                    }

                    if (dp[i][j] == 0) {
                        dp[i][j] = leftCost + rightCost + cost;
                    } else {
                        dp[i][j] = Math.min(dp[i][j], leftCost + rightCost + cost);
                    }
                }
            }
        }

        return dp[0][n - 1];
    }
}