import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int countWays(int[] nums, int target) {
        Map<Long, Integer> countMap = new HashMap<>();
        countMap.put(1L, 1);
        long product = 1;
        int mod = 1000000007;

        for (int num : nums) {
            Map<Long, Integer> newCountMap = new HashMap<>(countMap);
            for (long key : countMap.keySet()) {
                long newProduct = key * num;
                if (newProduct <= target) {
                    newCountMap.put(newProduct, (newCountMap.getOrDefault(newProduct, 0) + countMap.get(key)) % mod);
                }
            }
            countMap = newCountMap;
        }

        return countMap.getOrDefault((long) target, 0);
    }
}