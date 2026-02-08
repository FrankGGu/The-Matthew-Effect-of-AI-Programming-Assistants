public class Solution {

import java.util.*;

public class Solution {
    public int lengthOfLongestSubsequence(int[] nums, int target) {
        Map<Integer, Integer> dp = new HashMap<>();
        dp.put(0, 0);
        for (int num : nums) {
            Map<Integer, Integer> temp = new HashMap<>(dp);
            for (Map.Entry<Integer, Integer> entry : dp.entrySet()) {
                int key = entry.getKey();
                int value = entry.getValue();
                if (key + num <= target) {
                    temp.put(key + num, Math.max(temp.getOrDefault(key + num, 0), value + 1));
                }
            }
            dp = temp;
        }
        return dp.getOrDefault(target, -1);
    }
}
}