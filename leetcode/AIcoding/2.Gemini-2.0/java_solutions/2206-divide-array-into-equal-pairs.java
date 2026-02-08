import java.util.HashMap;
import java.util.Map;

class Solution {
    public boolean divideArray(int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        for (int value : count.values()) {
            if (value % 2 != 0) {
                return false;
            }
        }

        return true;
    }
}