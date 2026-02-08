class Solution {
    public long maximizeAmount(long initialAmount, int[] costs1, int[] profits1, int[] costs2, int[] profits2, int budget) {
        long maxTotalProfit = 0;

        for (int i = 0; i < costs1.length; i++) {
            if (costs1[i] <= budget) {
                maxTotalProfit = Math.max(maxTotalProfit, profits1[i]);
            }
        }

        for (int j = 0; j < costs2.length; j++) {
            if (costs2[j] <= budget) {
                maxTotalProfit = Math.max(maxTotalProfit, profits2[j]);
            }
        }

        for (int i = 0; i < costs1.length; i++) {
            for (int j = 0; j < costs2.length; j++) {
                int totalCost = costs1[i] + costs2[j];
                if (totalCost <= budget) {
                    long currentProfit = (long) profits1[i] + profits2[j];
                    maxTotalProfit = Math.max(maxTotalProfit, currentProfit);
                }
            }
        }

        return initialAmount + maxTotalProfit;
    }
}