import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minOperations(int[] nums) {
        Map<Integer, Integer> counts = new HashMap<>();
        for (int num : nums) {
            counts.put(num, counts.getOrDefault(num, 0) + 1);
        }

        int operations = 0;
        for (int count : counts.values()) {
            if (count == 1) {
                return -1;
            }
            operations += (count + 2) / 3;
        }

        return operations;
    }
}