import java.util.HashMap;
import java.util.Map;

class Solution {
    public int longestSubsequence(int[] arr, int difference) {
        Map<Integer, Integer> dp = new HashMap<>();
        int maxLen = 0;

        for (int num : arr) {
            int prevNum = num - difference;
            int length = dp.getOrDefault(prevNum, 0) + 1;
            dp.put(num, length);
            maxLen = Math.max(maxLen, length);
        }

        return maxLen;
    }
}