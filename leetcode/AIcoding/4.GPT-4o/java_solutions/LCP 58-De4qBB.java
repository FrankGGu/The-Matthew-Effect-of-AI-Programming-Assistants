class Solution {
    public int[] pileBox(int[][] box) {
        Arrays.sort(box, (a, b) -> (b[0] * b[1] - a[0] * a[1]));
        int n = box.length;
        int[] dp = new int[n];
        int maxHeight = 0;

        for (int i = 0; i < n; i++) {
            dp[i] = box[i][2];
            for (int j = 0; j < i; j++) {
                if (box[i][0] < box[j][0] && box[i][1] < box[j][1]) {
                    dp[i] = Math.max(dp[i], dp[j] + box[i][2]);
                }
            }
            maxHeight = Math.max(maxHeight, dp[i]);
        }

        return maxHeight;
    }
}