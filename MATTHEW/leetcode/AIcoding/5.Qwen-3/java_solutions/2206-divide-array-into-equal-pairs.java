public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public boolean divideArray(int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }
        for (int key : count.keySet()) {
            if (count.get(key) % 2 != 0) {
                return false;
            }
        }
        return true;
    }
}
}