import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minDays(int n) {
        Map<Integer, Integer> memo = new HashMap<>();
        return minDaysHelper(n, memo);
    }

    private int minDaysHelper(int n, Map<Integer, Integer> memo) {
        if (n <= 1) {
            return n;
        }

        if (memo.containsKey(n)) {
            return memo.get(n);
        }

        int days = 1 + Math.min(n % 2 + minDaysHelper(n / 2, memo),
                n % 3 + minDaysHelper(n / 3, memo));

        memo.put(n, days);
        return days;
    }
}