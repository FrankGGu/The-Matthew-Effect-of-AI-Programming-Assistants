public class Solution {

import java.util.*;

public class Solution {
    public int maximumLength(int[] nums) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        List<Integer> keys = new ArrayList<>(freq.keySet());
        Collections.sort(keys);

        int maxLen = 0;
        for (int i = keys.size() - 1; i >= 0; i--) {
            int key = keys.get(i);
            int count = freq.get(key);
            if (count > maxLen) {
                maxLen = count;
            }
            if (key % 2 == 0) {
                int half = key / 2;
                if (freq.containsKey(half)) {
                    maxLen = Math.max(maxLen, freq.get(half) + count);
                }
            }
        }

        return maxLen;
    }
}
}