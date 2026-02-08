import java.util.Arrays;

class Solution {
    public long maxTaxiEarnings(int n, int[][] rides) {
        Arrays.sort(rides, (a, b) -> a[0] - b[0]);
        long[] dp = new long[rides.length + 1];
        for (int i = 1; i <= rides.length; i++) {
            int start = rides[i - 1][0];
            int end = rides[i - 1][1];
            int tip = rides[i - 1][2];
            int index = binarySearch(rides, end);
            dp[i] = Math.max(dp[i - 1], (long) (end - start + tip) + dp[index]);
        }
        return dp[rides.length];
    }

    private int binarySearch(int[][] rides, int target) {
        int left = 0;
        int right = rides.length;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (rides[mid][0] >= target) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
}