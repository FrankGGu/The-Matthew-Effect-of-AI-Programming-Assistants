class Solution {
    public int maximizeWin(int[] prizePositions, int k) {
        int n = prizePositions.length;
        int left = 0;
        int maxLen = 0;
        for (int right = 0; right < n; right++) {
            while (prizePositions[right] - prizePositions[left] > 2 * k) {
                left++;
            }
            maxLen = Math.max(maxLen, right - left + 1);
        }

        int[] dp = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1];
            int l = 0, r = i - 1;
            int pos = -1;
            while (l <= r) {
                int mid = l + (r - l) / 2;
                if (prizePositions[i - 1] - prizePositions[mid] <= 2 * k) {
                    pos = mid;
                    r = mid - 1;
                } else {
                    l = mid + 1;
                }
            }
            if (pos != -1) {
                dp[i] = Math.max(dp[i], i - pos + (pos > 0 ? dp[pos] : 0));
            } else {
                dp[i] = Math.max(dp[i], i);
            }
        }

        return dp[n];
    }
}