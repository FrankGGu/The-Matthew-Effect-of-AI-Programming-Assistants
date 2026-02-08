public class Solution {

import java.util.Arrays;

public class Solution {
    public long minimumMoney(int[] transactions) {
        Arrays.sort(transactions, (a, b) -> (b - a));
        long total = 0;
        for (int t : transactions) {
            if (t > 0) {
                total += t;
            }
        }
        return total;
    }
}
}