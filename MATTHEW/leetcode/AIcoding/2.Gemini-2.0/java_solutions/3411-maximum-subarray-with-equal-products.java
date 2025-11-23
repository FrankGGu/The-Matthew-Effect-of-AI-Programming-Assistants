import java.util.HashMap;
import java.util.Map;

class Solution {
    public int equalProduct(int[] nums) {
        Map<Long, Integer> prefixProductMap = new HashMap<>();
        prefixProductMap.put(1L, -1);
        long product = 1;
        int maxLength = 0;
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 0) {
                product = 1;
                prefixProductMap.clear();
                prefixProductMap.put(1L, i);
                continue;
            }
            product *= nums[i];
            if (prefixProductMap.containsKey(product)) {
                maxLength = Math.max(maxLength, i - prefixProductMap.get(product));
            } else {
                prefixProductMap.put(product, i);
            }
        }
        return maxLength;
    }
}