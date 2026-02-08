class Solution {
    public int removeBoxes(int[] boxes) {
        int n = boxes.length;
        int[][][] memo = new int[n][n][n];
        return calculatePoints(boxes, 0, n - 1, 0, memo);
    }

    private int calculatePoints(int[] boxes, int i, int j, int k, int[][][] memo) {
        if (i > j) {
            return 0;
        }
        if (memo[i][j][k] > 0) {
            return memo[i][j][k];
        }

        int res = (k + 1) * (k + 1) + calculatePoints(boxes, i + 1, j, 0, memo);

        for (int m = i + 1; m <= j; m++) {
            if (boxes[m] == boxes[i]) {
                res = Math.max(res, calculatePoints(boxes, i + 1, m - 1, 0, memo) + calculatePoints(boxes, m, j, k + 1, memo));
            }
        }

        memo[i][j][k] = res;
        return res;
    }
}