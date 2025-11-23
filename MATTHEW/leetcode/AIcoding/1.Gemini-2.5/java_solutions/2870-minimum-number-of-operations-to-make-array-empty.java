import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minOperations(int[] nums) {
        Map<Integer, Integer> counts = new HashMap<>();
        for (int num : nums) {
            counts.put(num, counts.getOrDefault(num, 0) + 1);
        }

        int totalOperations = 0;
        for (int count : counts.values()) {
            if (count == 1) {
                return -1;
            }

            // For any count > 1, we can always make it empty using operations of 2 or 3.
            // The minimum number of operations for a given count 'c' is:
            // If c % 3 == 0, operations = c / 3
            // If c % 3 == 1, operations = c / 3 + 1 (e.g., 4 = 2+2, 7 = 3+2+2)
            // If c % 3 == 2, operations = c / 3 + 1 (e.g., 2 = 2, 5 = 3+2)
            // This can be elegantly expressed using ceiling division: (count + 2) / 3
            totalOperations += (count + 2) / 3;
        }

        return totalOperations;
    }
}