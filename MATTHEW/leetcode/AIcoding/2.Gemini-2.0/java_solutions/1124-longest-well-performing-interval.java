import java.util.HashMap;
import java.util.Map;

class Solution {
    public int longestWPI(int[] hours) {
        int n = hours.length;
        int ans = 0;
        int balance = 0;
        Map<Integer, Integer> seen = new HashMap<>();

        for (int i = 0; i < n; i++) {
            balance += (hours[i] > 8) ? 1 : -1;

            if (balance > 0) {
                ans = i + 1;
            } else {
                if (!seen.containsKey(balance)) {
                    seen.put(balance, i);
                }
                if (seen.containsKey(balance - 1)) {
                    ans = Math.max(ans, i - seen.get(balance - 1));
                }
            }
        }

        return ans;
    }
}