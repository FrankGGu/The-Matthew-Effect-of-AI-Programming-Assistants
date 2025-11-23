import java.util.Arrays;

class Solution {
    public int maxValue(int[][] events, int k) {
        Arrays.sort(events, (a, b) -> a[1] - b[1]);
        int n = events.length;
        int[][] dp = new int[n + 1][k + 1];

        for (int i = 1; i <= n; i++) {
            int start = events[i - 1][0];
            int value = events[i - 1][2];

            int lastNonOverlapping = binarySearch(events, i - 1, start);

            for (int j = 1; j <= k; j++) {
                dp[i][j] = Math.max(dp[i - 1][j], dp[lastNonOverlapping + 1][j - 1] + value);
            }
        }

        return dp[n][k];
    }

    private int binarySearch(int[][] events, int end, int target) {
        int left = 0;
        int right = end;
        int result = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (events[mid][1] < target) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return result;
    }
}