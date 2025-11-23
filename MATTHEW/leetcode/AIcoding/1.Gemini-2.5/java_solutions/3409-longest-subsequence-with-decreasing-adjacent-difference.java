import java.util.HashMap;
import java.util.Map;

class Solution {
    public int longestSubsequence(int[] arr, int difference) {
        Map<Integer, Integer> dp = new HashMap<>();
        int maxLength = 0;

        for (int num : arr) {
            int prevNum = num - difference;
            int currentLength = 1 + dp.getOrDefault(prevNum, 0);
            dp.put(num, currentLength);
            maxLength = Math.max(maxLength, currentLength);
        }

        return maxLength;
    }
}