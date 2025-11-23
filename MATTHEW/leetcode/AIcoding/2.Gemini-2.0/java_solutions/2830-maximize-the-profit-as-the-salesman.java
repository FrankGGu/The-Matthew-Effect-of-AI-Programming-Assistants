import java.util.Arrays;

class Solution {
    public int maximizeTheProfit(int n, int[][] offers) {
        Arrays.sort(offers, (a, b) -> a[0] - b[0]);
        int[] dp = new int[offers.length + 1];
        for (int i = 1; i <= offers.length; i++) {
            int[] offer = offers[i - 1];
            int start = offer[0];
            int end = offer[1];
            int gold = offer[2];
            int prevIndex = -1;
            int low = 0, high = i - 1;
            while (low <= high) {
                int mid = low + (high - low) / 2;
                if (offers[mid][1] < start) {
                    prevIndex = mid;
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
            int prevProfit = (prevIndex == -1) ? 0 : dp[prevIndex + 1];
            dp[i] = Math.max(dp[i - 1], prevProfit + gold);
        }
        return dp[offers.length];
    }
}