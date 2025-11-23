public class Solution {

import java.util.*;

public class Solution {
    public int maximumLength(int[] nums) {
        int n = nums.length;
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        List<Map.Entry<Integer, Integer>> list = new ArrayList<>(count.entrySet());
        list.sort((a, b) -> b.getKey() - a.getKey());

        int maxLen = 0;
        int prev = -1;
        for (Map.Entry<Integer, Integer> entry : list) {
            int num = entry.getKey();
            int freq = entry.getValue();
            if (prev == -1 || num != prev) {
                maxLen += freq;
                prev = num;
            } else {
                maxLen += freq - 1;
                prev = num;
            }
        }

        return maxLen;
    }
}
}