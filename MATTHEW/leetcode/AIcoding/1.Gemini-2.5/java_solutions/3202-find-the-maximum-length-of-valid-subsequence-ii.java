import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxLengthOfValidSubsequenceII(int[] nums) {
        Map<Integer, Integer> dp = new HashMap<>();
        int maxLen = 0;

        for (int num : nums) {
            int lenFromPrev = dp.getOrDefault(num - 1, 0);
            int lenFromSame = dp.getOrDefault(num, 0);
            int lenFromNext = dp.getOrDefault(num + 1, 0);

            int currentNumMaxLen = Math.max(lenFromPrev, Math.max(lenFromSame, lenFromNext)) + 1;

            dp.put(num, currentNumMaxLen);

            maxLen = Math.max(maxLen, currentNumMaxLen);
        }

        return maxLen;
    }
}