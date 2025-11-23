import java.util.Arrays;

class Solution {
    public int boxDelivering(int[][] boxes, int portsCount, int maxBoxes, int maxWeight) {
        int n = boxes.length;
        int[] p = new int[n + 1];
        int[] w = new int[n + 1];
        long[] weightSum = new long[n + 1];
        int[] dp = new int[n + 1];

        for (int i = 1; i <= n; i++) {
            p[i] = boxes[i - 1][0];
            w[i] = boxes[i - 1][1];
            weightSum[i] = weightSum[i - 1] + w[i];
        }

        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = i; j >= 1; j--) {
                if (i - j + 1 > maxBoxes || weightSum[i] - weightSum[j - 1] > maxWeight) {
                    break;
                }

                int trips = dp[j - 1] + 1;
                int changes = 0;
                for (int k = j + 1; k <= i; k++) {
                    if (p[k] != p[k - 1]) {
                        changes++;
                    }
                }
                trips += changes;
                dp[i] = Math.min(dp[i], trips);
            }
        }

        return dp[n];
    }
}