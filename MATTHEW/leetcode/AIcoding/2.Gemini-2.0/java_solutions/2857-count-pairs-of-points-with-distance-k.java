import java.util.HashMap;
import java.util.Map;

class Solution {
    public int countPairs(int[] x, int[] y, int k) {
        Map<Integer, Integer> count = new HashMap<>();
        int ans = 0;
        for (int i = 0; i < x.length; i++) {
            for (int a = 0; a <= k; a++) {
                int b = k - a;
                int targetX = x[i] ^ a;
                int targetY = y[i] ^ b;
                int hash = (targetX << 10) | targetY;
                ans += count.getOrDefault(hash, 0);
            }
            int hash = (x[i] << 10) | y[i];
            count.put(hash, count.getOrDefault(hash, 0) + 1);
        }
        return ans;
    }
}