import java.util.List;
import java.util.HashMap;
import java.util.Map;

class Solution {
    private static final int MOD = 1_000_000_007;

    public int goodPartitions(List<Integer> nums) {
        Map<Integer, Integer> lastOccurrence = new HashMap<>();
        for (int i = 0; i < nums.size(); i++) {
            lastOccurrence.put(nums.get(i), i);
        }

        int countOfFixedSegments = 0;
        int currentMaxReach = 0; 

        for (int i = 0; i < nums.size(); i++) {
            currentMaxReach = Math.max(currentMaxReach, lastOccurrence.get(nums.get(i)));
            if (i == currentMaxReach) {
                countOfFixedSegments++;
            }
        }

        return power(2, countOfFixedSegments - 1);
    }

    private int power(long base, long exp) {
        long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp /= 2;
        }
        return (int) res;
    }
}