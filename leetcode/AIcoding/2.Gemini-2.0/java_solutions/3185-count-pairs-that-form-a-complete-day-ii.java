import java.util.HashMap;
import java.util.Map;

class Solution {
    public long countPairs(int[] time) {
        Map<Integer, Integer> count = new HashMap<>();
        long ans = 0;
        for (int t : time) {
            for (int i = 0; i <= 60; i++) {
                int target = 60 * 24 - t + i;
                target %= (60 * 24);
                if (target < 0) target += (60 * 24);
                ans += count.getOrDefault(target, 0);
            }
            count.put(t, count.getOrDefault(t, 0) + 1);
        }
        return ans;
    }
}