public class Solution {

import java.util.*;

public class Solution {
    public int longestSubarray(int[] nums) {
        int max = 0;
        int count = 0;
        int result = 0;

        for (int num : nums) {
            if (num == max) {
                count++;
            } else {
                max = num;
                count = 1;
            }
            result = Math.max(result, count);
        }

        return result;
    }
}
}