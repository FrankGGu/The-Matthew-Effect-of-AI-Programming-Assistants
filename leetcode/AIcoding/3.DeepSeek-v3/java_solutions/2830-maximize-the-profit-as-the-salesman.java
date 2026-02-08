import java.util.Arrays;

class Solution {
    public int maximizeTheProfit(int n, List<List<Integer>> offers) {
        Collections.sort(offers, (a, b) -> a.get(1) - b.get(1));
        int m = offers.size();
        int[] dp = new int[m + 1];
        for (int i = 1; i <= m; i++) {
            List<Integer> offer = offers.get(i - 1);
            int start = offer.get(0);
            int end = offer.get(1);
            int gold = offer.get(2);
            int last = -1;
            int left = 0, right = i - 1;
            while (left <= right) {
                int mid = (left + right) / 2;
                if (offers.get(mid).get(1) < start) {
                    last = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            dp[i] = Math.max(dp[i - 1], (last == -1 ? 0 : dp[last + 1]) + gold);
        }
        return dp[m];
    }
}