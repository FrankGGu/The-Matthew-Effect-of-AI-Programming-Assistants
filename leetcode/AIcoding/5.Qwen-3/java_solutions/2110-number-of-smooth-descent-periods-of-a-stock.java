public class Solution {
    public long getDescentPeriods(long[] prices) {
        long count = 0;
        int n = prices.length;
        for (int i = 0; i < n; i++) {
            int j = i;
            while (j + 1 < n && prices[j] - prices[j + 1] == 1) {
                j++;
            }
            long length = j - i + 1;
            count += length * (length + 1) / 2;
            i = j;
        }
        return count;
    }
}