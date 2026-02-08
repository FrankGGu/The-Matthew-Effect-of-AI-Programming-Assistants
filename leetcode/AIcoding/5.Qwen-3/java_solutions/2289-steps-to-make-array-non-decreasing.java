public class Solution {

import java.util.*;

public class Solution {
    public int totalSteps(int[] nums) {
        int n = nums.length;
        int[] dp = new int[n];
        int maxSteps = 0;

        for (int i = 1; i < n; i++) {
            if (nums[i] < nums[i - 1]) {
                dp[i] = 1;
                maxSteps = Math.max(maxSteps, dp[i]);
            } else {
                dp[i] = 0;
            }
        }

        for (int i = 1; i < n; i++) {
            if (nums[i] >= nums[i - 1]) {
                continue;
            }
            int steps = 1;
            int j = i - 1;
            while (j >= 0 && nums[j] > nums[j + 1]) {
                steps = Math.max(steps, dp[j] + 1);
                j--;
            }
            dp[i] = steps;
            maxSteps = Math.max(maxSteps, steps);
        }

        return maxSteps;
    }
}
}