public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int maxEvenOddDifference(int[] nums) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        int maxDiff = 0;
        for (Map.Entry<Integer, Integer> entry : freq.entrySet()) {
            int value = entry.getKey();
            int count = entry.getValue();
            if (count % 2 == 0) {
                maxDiff = Math.max(maxDiff, value);
            } else {
                maxDiff = Math.max(maxDiff, -value);
            }
        }

        return maxDiff;
    }
}
}