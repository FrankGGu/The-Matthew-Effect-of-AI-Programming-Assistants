public class RemoveBoxes {
    public int removeBoxes(int[] boxes) {
        int n = boxes.length;
        int[][][] dp = new int[n][n][n];
        return removeBoxesSub(boxes, 0, n - 1, 0, dp);
    }

    private int removeBoxesSub(int[] boxes, int l, int r, int k, int[][][] dp) {
        if (l > r) return 0;
        if (dp[l][r][k] != 0) return dp[l][r][k];

        while (l < r && boxes[r] == boxes[r - 1]) {
            r--;
            k++;
        }

        dp[l][r][k] = removeBoxesSub(boxes, l, r - 1, 0, dp) + (k + 1) * (k + 1);

        for (int i = l; i < r; i++) {
            if (boxes[i] == boxes[r]) {
                dp[l][r][k] = Math.max(dp[l][r][k], removeBoxesSub(boxes, l, i, k + 1, dp) + removeBoxesSub(boxes, i + 1, r - 1, 0, dp));
            }
        }

        return dp[l][r][k];
    }
}