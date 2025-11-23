import java.util.HashMap;
import java.util.Map;

class Solution {
    public int longestSubsequence(int[] arr, int difference) {
        Map<Integer, Integer> dp = new HashMap<>();
        int maxLen = 1;
        for (int num : arr) {
            int prev = num - difference;
            int len = dp.getOrDefault(prev, 0) + 1;
            dp.put(num, len);
            maxLen = Math.max(maxLen, len);
        }
        return maxLen;
    }
}