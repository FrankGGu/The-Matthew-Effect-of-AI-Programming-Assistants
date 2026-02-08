import java.util.HashMap;
import java.util.Map;

public class Solution {
    public double getProbability(int[] balls) {
        int totalBalls = 0;
        for (int count : balls) {
            totalBalls += count;
        }
        int totalWays = combination(totalBalls, totalBalls / 2);
        Map<Integer, Integer> ballCountMap = new HashMap<>();
        for (int count : balls) {
            if (count > 0) {
                ballCountMap.put(count, ballCountMap.getOrDefault(count, 0) + 1);
            }
        }
        int validWays = 1;
        for (int count : ballCountMap.keySet()) {
            validWays *= combination(count, count / 2);
        }
        return (double) validWays / totalWays;
    }

    private int combination(int n, int k) {
        if (k > n) return 0;
        if (k == 0 || k == n) return 1;
        k = Math.min(k, n - k);
        int result = 1;
        for (int i = 0; i < k; i++) {
            result = result * (n - i) / (i + 1);
        }
        return result;
    }
}