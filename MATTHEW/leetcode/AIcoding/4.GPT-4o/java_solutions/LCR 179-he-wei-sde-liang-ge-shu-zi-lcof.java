import java.util.HashMap;

public class Solution {
    public int[] twoSum(int[] prices, int target) {
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < prices.length; i++) {
            int complement = target - prices[i];
            if (map.containsKey(complement)) {
                return new int[] { map.get(complement), i };
            }
            map.put(prices[i], i);
        }
        return new int[] {};
    }
}