public class Solution {

import java.util.*;

public class Solution {
    public int minArrayLength(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[n];
        Arrays.fill(dp, 1);

        for (int i = 1; i < n; i++) {
            for (int j = 0; j < i; j++) {
                if (nums[i] % nums[j] == 0 || nums[j] % nums[i] == 0) {
                    dp[i] = Math.min(dp[i], dp[j] + 1);
                }
            }
        }

        return Arrays.stream(dp).min().getAsInt();
    }
}
}