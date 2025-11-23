public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int numIdenticalPairs(int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        int result = 0;
        for (int num : nums) {
            result += count.getOrDefault(num, 0);
            count.put(num, count.getOrDefault(num, 0) + 1);
        }
        return result;
    }
}
}