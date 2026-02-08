public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int findPairs(int[] nums, int k) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        int result = 0;
        for (Map.Entry<Integer, Integer> entry : count.entrySet()) {
            int key = entry.getKey();
            if (k == 0) {
                if (entry.getValue() >= 2) {
                    result++;
                }
            } else {
                if (count.containsKey(key + k)) {
                    result++;
                }
            }
        }
        return result;
    }
}
}