public class Solution {

import java.util.*;

public class Solution {
    public int sumOfSubsets(int[] nums, int maxSum) {
        int n = nums.length;
        int[] freq = new int[101];
        for (int num : nums) {
            freq[num]++;
        }
        int[] dp = new int[maxSum + 1];
        dp[0] = 1;
        for (int num = 1; num <= 100; num++) {
            if (freq[num] == 0) continue;
            int count = freq[num];
            int[] temp = Arrays.copyOf(dp, maxSum + 1);
            for (int j = num; j <= maxSum; j++) {
                if (dp[j - num] > 0) {
                    temp[j] += dp[j - num];
                    if (temp[j] > Integer.MAX_VALUE) temp[j] = Integer.MAX_VALUE;
                }
            }
            dp = temp;
        }
        return dp[maxSum];
    }
}
}