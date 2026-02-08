public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int findShortestSubArray(int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        Map<Integer, Integer> firstOccur = new HashMap<>();
        Map<Integer, Integer> lastOccur = new HashMap<>();

        for (int i = 0; i < nums.length; i++) {
            int num = nums[i];
            count.put(num, count.getOrDefault(num, 0) + 1);
            if (!firstOccur.containsKey(num)) {
                firstOccur.put(num, i);
            }
            lastOccur.put(num, i);
        }

        int minLength = Integer.MAX_VALUE;
        int maxCount = 0;

        for (int key : count.keySet()) {
            int currentCount = count.get(key);
            if (currentCount > maxCount) {
                maxCount = currentCount;
                minLength = lastOccur.get(key) - firstOccur.get(key) + 1;
            } else if (currentCount == maxCount) {
                minLength = Math.min(minLength, lastOccur.get(key) - firstOccur.get(key) + 1);
            }
        }

        return minLength;
    }
}
}