public class Solution {

import java.util.*;

public class Solution {
    public int longestArithSeqLength(int[] nums) {
        if (nums == null || nums.length < 2) return nums == null ? 0 : nums.length;

        Map<Integer, Integer>[] dp = new HashMap[nums.length];
        int maxLength = 2;

        for (int i = 0; i < nums.length; i++) {
            dp[i] = new HashMap<>();
            for (int j = 0; j < i; j++) {
                int diff = nums[i] - nums[j];
                int count = dp[j].getOrDefault(diff, 1) + 1;
                dp[i].put(diff, count);
                maxLength = Math.max(maxLength, count);
            }
        }

        return maxLength;
    }
}
}