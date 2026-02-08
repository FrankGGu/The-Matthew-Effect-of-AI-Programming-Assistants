import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxFrequencyElements(int[] nums) {
        Map<Integer, Integer> counts = new HashMap<>();
        for (int num : nums) {
            counts.put(num, counts.getOrDefault(num, 0) + 1);
        }

        int maxFrequency = 0;
        for (int count : counts.values()) {
            maxFrequency = Math.max(maxFrequency, count);
        }

        int result = 0;
        for (int count : counts.values()) {
            if (count == maxFrequency) {
                result += maxFrequency;
            }
        }

        return result;
    }
}