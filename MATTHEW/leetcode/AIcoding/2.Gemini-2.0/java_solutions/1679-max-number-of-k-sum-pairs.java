import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxOperations(int[] nums, int k) {
        Map<Integer, Integer> count = new HashMap<>();
        int operations = 0;
        for (int num : nums) {
            int complement = k - num;
            if (count.containsKey(complement) && count.get(complement) > 0) {
                operations++;
                count.put(complement, count.get(complement) - 1);
            } else {
                count.put(num, count.getOrDefault(num, 0) + 1);
            }
        }
        return operations;
    }
}