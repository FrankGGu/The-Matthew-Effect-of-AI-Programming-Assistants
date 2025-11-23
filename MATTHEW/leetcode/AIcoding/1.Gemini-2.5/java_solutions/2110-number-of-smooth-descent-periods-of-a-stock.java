class Solution {
    public long smoothDescentPeriods(int[] prices) {
        long totalSmoothPeriods = 0;
        long currentSmoothLength = 0;

        for (int i = 0; i < prices.length; i++) {
            if (i == 0 || prices[i] != prices[i - 1] - 1) {
                currentSmoothLength = 1;
            } else {
                currentSmoothLength++;
            }
            totalSmoothPeriods += currentSmoothLength;
        }

        return totalSmoothPeriods;
    }
}