import java.util.HashMap;
import java.util.Map;

class Solution {
    private Map<Integer, Integer> memo;

    public int minDays(int n) {
        memo = new HashMap<>();
        return dp(n);
    }

    private int dp(int n) {
        if (n <= 1) {
            return n;
        }
        if (memo.containsKey(n)) {
            return memo.get(n);
        }

        int ans = 1 + dp(n - 1);

        if (n % 2 == 0) {
            ans = Math.min(ans, 1 + dp(n / 2));
        }

        if (n % 3 == 0) {
            ans = Math.min(ans, 1 + dp(n / 3));
        }

        memo.put(n, ans);
        return ans;
    }
}