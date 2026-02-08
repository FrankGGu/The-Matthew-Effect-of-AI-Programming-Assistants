class Solution {
    public long minimumMoney(int[][] transactions) {
        long totalLoss = 0;
        int maxCashback = 0;
        int maxCost = 0;

        for (int[] t : transactions) {
            int cost = t[0];
            int cashback = t[1];
            if (cost > cashback) {
                totalLoss += cost - cashback;
                maxCashback = Math.max(maxCashback, cashback);
            } else {
                maxCost = Math.max(maxCost, cost);
            }
        }

        return totalLoss + Math.max(maxCashback, maxCost);
    }
}