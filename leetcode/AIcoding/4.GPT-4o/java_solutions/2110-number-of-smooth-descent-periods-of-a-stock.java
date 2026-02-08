class Solution {
    public long getDescentPeriods(int[] prices) {
        long count = 0;
        int n = prices.length;
        int streak = 1;

        for (int i = 1; i < n; i++) {
            if (prices[i] == prices[i - 1] - 1) {
                streak++;
            } else {
                streak = 1;
            }
            count += streak;
        }

        return count + n; // including each single day
    }
}