class Solution {
    public int maximizeWin(int[] prizePositions, int k) {
        int n = prizePositions.length;
        if (n == 0) return 0;
        int[] dp = new int[n + 1];
        int res = 0;
        int left = 0;
        for (int right = 0; right < n; right++) {
            while (prizePositions[right] - prizePositions[left] > k) {
                left++;
            }
            int current = right - left + 1;
            dp[right + 1] = Math.max(dp[right], current);
            res = Math.max(res, current + dp[left]);
        }
        return res;
    }
}