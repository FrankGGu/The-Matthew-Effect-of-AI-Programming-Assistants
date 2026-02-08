import java.util.Arrays;

class Solution {
    public long minimumMoney(int[][] transactions) {
        long loss = 0;
        int maxCost = 0;
        int n = transactions.length;
        int[][] gainLoss = new int[n][2];
        int k = 0;
        for (int[] transaction : transactions) {
            int cost = transaction[0];
            int cashback = transaction[1];
            if (cost > cashback) {
                gainLoss[k][0] = cost;
                gainLoss[k][1] = cashback;
                k++;
            } else {
                loss += cost - cashback;
            }
        }

        Arrays.sort(gainLoss, 0, k, (a, b) -> b[1] - a[1]);

        long currentMoney = 0;
        for (int i = 0; i < k; i++) {
            currentMoney += gainLoss[i][0];
            maxCost = Math.max(maxCost, gainLoss[i][1]);
            currentMoney -= gainLoss[i][1];
        }

        return Math.max(currentMoney + loss, maxCost + loss);
    }
}