public class Solution {

import java.util.*;

public class Solution {
    public boolean isSplitPossible(List<Integer> nums, int k) {
        int n = nums.size();
        if (n < 2) return false;
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        if (sum % k != 0) return false;
        int target = sum / k;
        int[] dp = new int[k];
        dp[0] = nums.get(0);
        for (int i = 1; i < n; i++) {
            int[] newDp = Arrays.copyOf(dp, k);
            for (int j = 0; j < k; j++) {
                if (dp[j] + nums.get(i) <= target) {
                    newDp[j] = dp[j] + nums.get(i);
                }
            }
            dp = newDp;
        }
        for (int val : dp) {
            if (val == target) return true;
        }
        return false;
    }
}
}