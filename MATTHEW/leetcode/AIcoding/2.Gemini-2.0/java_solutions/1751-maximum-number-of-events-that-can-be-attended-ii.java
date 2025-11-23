class Solution {
    public int maxValue(int[][] events, int k) {
        Arrays.sort(events, (a, b) -> a[0] - b[0]);
        int n = events.length;
        int[][] dp = new int[n + 1][k + 1];

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                int start = events[i - 1][0];
                int end = events[i - 1][1];
                int value = events[i - 1][2];

                int nextIndex = findNextEvent(events, end);

                dp[i][j] = Math.max(dp[i - 1][j], value + dp[nextIndex][j - 1]);
            }
        }

        return dp[n][k];
    }

    private int findNextEvent(int[][] events, int end) {
        int left = 0;
        int right = events.length;

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (events[mid][0] <= end) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return left;
    }
}