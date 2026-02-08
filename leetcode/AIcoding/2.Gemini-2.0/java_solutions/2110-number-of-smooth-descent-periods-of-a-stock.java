class Solution {
    public long getDescentPeriods(int[] prices) {
        long ans = 0;
        int n = prices.length;
        int len = 1;
        for (int i = 0; i < n; i++) {
            if (i > 0 && prices[i] == prices[i - 1] - 1) {
                len++;
            } else {
                len = 1;
            }
            ans += len;
        }
        return ans;
    }
}