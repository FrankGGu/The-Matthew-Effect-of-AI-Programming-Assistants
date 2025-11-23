import java.util.HashMap;
import java.util.Map;

class Solution {
    public int mostFrequentEven(int[] nums) {
        Map<Integer, Integer> counts = new HashMap<>();
        for (int num : nums) {
            if (num % 2 == 0) {
                counts.put(num, counts.getOrDefault(num, 0) + 1);
            }
        }

        int mostFrequent = -1;
        int maxCount = 0;

        for (Map.Entry<Integer, Integer> entry : counts.entrySet()) {
            int num = entry.getKey();
            int count = entry.getValue();

            if (count > maxCount) {
                maxCount = count;
                mostFrequent = num;
            } else if (count == maxCount && num < mostFrequent) {
                mostFrequent = num;
            }
        }

        return mostFrequent;
    }
}