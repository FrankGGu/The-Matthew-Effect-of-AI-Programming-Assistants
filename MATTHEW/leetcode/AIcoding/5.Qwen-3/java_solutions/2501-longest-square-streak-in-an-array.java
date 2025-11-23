public class Solution {

import java.util.*;

public class Solution {
    public int longestSquareStreak(int[] nums) {
        Arrays.sort(nums);
        Map<Integer, Integer> dp = new HashMap<>();
        int maxLen = 0;

        for (int num : nums) {
            int sqrt = (int) Math.sqrt(num);
            if (sqrt * sqrt == num && dp.containsKey(sqrt)) {
                dp.put(num, dp.get(sqrt) + 1);
                maxLen = Math.max(maxLen, dp.get(num));
            } else {
                dp.put(num, 1);
            }
        }

        return maxLen >= 2 ? maxLen : -1;
    }
}
}