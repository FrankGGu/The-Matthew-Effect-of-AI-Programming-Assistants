class Solution {
    public long getDescentPeriods(int[] prices) {
        long result = 1;
        long current = 1;
        for (int i = 1; i < prices.length; i++) {
            if (prices[i] == prices[i - 1] - 1) {
                current += 1;
            } else {
                current = 1;
            }
            result += current;
        }
        return result;
    }
}