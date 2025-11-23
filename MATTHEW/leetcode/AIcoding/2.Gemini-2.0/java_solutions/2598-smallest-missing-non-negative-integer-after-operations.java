import java.util.HashMap;
import java.util.Map;

class Solution {
    public int smallestMissing(int[] nums, int value) {
        int n = nums.length;
        Map<Integer, Integer> counts = new HashMap<>();
        for (int num : nums) {
            int remainder = (num % value + value) % value;
            counts.put(remainder, counts.getOrDefault(remainder, 0) + 1);
        }

        int missing = 0;
        while (true) {
            int remainder = (missing % value + value) % value;
            if (counts.containsKey(remainder) && counts.get(remainder) > 0) {
                counts.put(remainder, counts.get(remainder) - 1);
                if (counts.get(remainder) == 0) {
                    counts.remove(remainder);
                }
                missing++;
            } else {
                return missing;
            }
        }
    }
}