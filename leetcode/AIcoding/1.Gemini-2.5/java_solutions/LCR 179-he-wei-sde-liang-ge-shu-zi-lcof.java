import java.util.HashMap;
import java.util.Map;

class Solution {
    public int[] twoSum(int[] prices, int target) {
        Map<Integer, Integer> priceMap = new HashMap<>();
        for (int i = 0; i < prices.length; i++) {
            int complement = target - prices[i];
            if (priceMap.containsKey(complement)) {
                return new int[]{priceMap.get(complement), i};
            }
            priceMap.put(prices[i], i);
        }
        return new int[0]; // Should not reach here based on problem constraints (exactly one solution)
    }
}