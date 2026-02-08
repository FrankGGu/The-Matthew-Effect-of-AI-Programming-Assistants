import java.util.HashMap;
import java.util.Map;

class Solution {
    public int tupleSameProduct(int[] nums) {
        int n = nums.length;
        Map<Integer, Integer> count = new HashMap<>();
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int product = nums[i] * nums[j];
                count.put(product, count.getOrDefault(product, 0) + 1);
            }
        }
        int ans = 0;
        for (int value : count.values()) {
            ans += value * (value - 1) / 2;
        }
        return ans * 8;
    }
}