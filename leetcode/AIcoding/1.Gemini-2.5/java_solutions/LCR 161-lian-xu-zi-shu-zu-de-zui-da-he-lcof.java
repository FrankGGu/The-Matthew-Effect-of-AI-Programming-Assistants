class Solution {
    public int maxSubArray(int[] sales) {
        if (sales == null || sales.length == 0) {
            return 0;
        }

        int maxSoFar = sales[0];
        int currentMax = sales[0];

        for (int i = 1; i < sales.length; i++) {
            currentMax = Math.max(sales[i], currentMax + sales[i]);
            maxSoFar = Math.max(maxSoFar, currentMax);
        }

        return maxSoFar;
    }
}