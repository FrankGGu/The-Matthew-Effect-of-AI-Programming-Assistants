import java.util.Arrays;

class Solution {
    public long cutBamboo(int[] bamboo_height, int A, int B, int C, int D) {
        int maxH = 0;
        for (int h : bamboo_height) {
            if (h > maxH) {
                maxH = h;
            }
        }

        long[] dp = new long[maxH + 1];
        dp[1] = 0;

        for (int i = 2; i <= maxH; i++) {
            long cost1 = (long)A + (long)B * i + dp[i / 2];
            long cost2 = (long)C + (long)D * i + dp[i - 1];

            dp[i] = Math.min(cost1, cost2);
        }

        long totalMinCost = 0;
        for (int h : bamboo_height) {
            totalMinCost += dp[h];
        }

        return totalMinCost;
    }
}