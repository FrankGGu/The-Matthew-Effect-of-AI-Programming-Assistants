class Solution {
    public int removeBoxes(int[] boxes) {
        int n = boxes.length;
        int[][][] dp = new int[n][n][n + 1];
        return dfs(boxes, 0, n - 1, 0, dp);
    }

    private int dfs(int[] boxes, int left, int right, int k, int[][][] dp) {
        if (left > right) return 0;
        if (dp[left][right][k] > 0) return dp[left][right][k];

        while (right > left && boxes[right] == boxes[right - 1]) {
            right--;
            k++;
        }

        dp[left][right][k] = dfs(boxes, left, right - 1, 0, dp) + (k + 1) * (k + 1);
        for (int i = left; i < right; i++) {
            if (boxes[i] == boxes[right]) {
                dp[left][right][k] = Math.max(dp[left][right][k], dfs(boxes, left, i, k + 1, dp) + dfs(boxes, i + 1, right - 1, 0, dp));
            }
        }

        return dp[left][right][k];
    }
}