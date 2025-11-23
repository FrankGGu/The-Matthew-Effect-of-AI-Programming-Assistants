public class Solution {

import java.util.*;

public class Solution {
    public List<Long> findLongestSubarray(long[] nums) {
        Map<Long, Integer> firstOccurrence = new HashMap<>();
        Map<Long, Integer> lastOccurrence = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            if (!firstOccurrence.containsKey(nums[i])) {
                firstOccurrence.put(nums[i], i);
            }
            lastOccurrence.put(nums[i], i);
        }

        List<Long> result = new ArrayList<>();
        int maxLen = 0;
        for (Map.Entry<Long, Integer> entry : firstOccurrence.entrySet()) {
            long num = entry.getKey();
            int start = entry.getValue();
            int end = lastOccurrence.get(num);
            if (end - start + 1 > maxLen) {
                maxLen = end - start + 1;
                result.clear();
                result.add(num);
            } else if (end - start + 1 == maxLen) {
                result.add(num);
            }
        }

        return result;
    }
}
}