import java.util.Arrays;

public class Solution {
    public int boxDelivering(int[][] boxes, int portsCount, int maxBoxes, int maxWeight) {
        int n = boxes.length;
        int[] dp = new int[n + 1];
        int[] prefixWeight = new int[n + 1];
        int trips = 0;

        for (int i = 1; i <= n; i++) {
            prefixWeight[i] = prefixWeight[i - 1] + boxes[i - 1][1];
        }

        for (int i = 1; i <= n; i++) {
            dp[i] = Integer.MAX_VALUE;
            int weight = 0, count = 0;

            for (int j = i; j >= 1; j--) {
                weight += boxes[j - 1][1];
                count++;

                if (count > maxBoxes || weight > maxWeight) break;

                int lastPort = boxes[j - 1][0];
                int tripsCost = 1;

                if (j < i) {
                    tripsCost += (boxes[j - 1][0] != boxes[j][0]) ? 1 : 0;
                }

                dp[i] = Math.min(dp[i], dp[j - 1] + tripsCost);
            }
        }

        return dp[n];
    }
}