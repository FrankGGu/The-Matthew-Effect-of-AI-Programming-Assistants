import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public long maximizeTheProfit(int n, int[][] offers) {
        Arrays.sort(offers, Comparator.comparingInt(o -> o[1]));

        int m = offers.length;
        long[] dp = new long[m + 1];

        for (int i = 1; i <= m; i++) {
            int[] currentOffer = offers[i - 1];
            long profitIfSkipped = dp[i - 1];

            long profitIfTaken = currentOffer[2];
            int prevNonOverlappingOfferIndex = findPreviousNonOverlappingOffer(offers, i - 1, currentOffer[0]);

            if (prevNonOverlappingOfferIndex != -1) {
                profitIfTaken += dp[prevNonOverlappingOfferIndex + 1];
            }

            dp[i] = Math.max(profitIfSkipped, profitIfTaken);
        }

        return dp[m];
    }

    private int findPreviousNonOverlappingOffer(int[][] offers, int endIndexExclusive, int targetStart) {
        int low = 0;
        int high = endIndexExclusive - 1;
        int ans = -1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (offers[mid][1] < targetStart) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }
}