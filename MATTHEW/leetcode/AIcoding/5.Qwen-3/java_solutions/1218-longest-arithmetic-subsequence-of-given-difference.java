public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int longestSubsequence(int[] nums, int difference) {
        Map<Integer, Integer> dp = new HashMap<>();
        int maxLen = 0;
        for (int num : nums) {
            int prev = dp.getOrDefault(num - difference, 0);
            dp.put(num, prev + 1);
            maxLen = Math.max(maxLen, prev + 1);
        }
        return maxLen;
    }
}
}