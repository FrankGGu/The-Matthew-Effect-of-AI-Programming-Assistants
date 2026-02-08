public class Solution {

import java.util.*;

public class Solution {
    public int longestAlternatingSubarray(int[] nums) {
        int n = nums.length;
        int maxLen = 1;
        int currentLen = 1;

        for (int i = 1; i < n; i++) {
            if ((nums[i] > nums[i - 1] && nums[i - 1] < nums[i - 2]) || (nums[i] < nums[i - 1] && nums[i - 1] > nums[i - 2])) {
                currentLen++;
                maxLen = Math.max(maxLen, currentLen);
            } else {
                currentLen = 1;
            }
        }

        return maxLen;
    }
}
}