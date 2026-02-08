public class Solution {

import java.util.*;

public class Solution {
    public int numFactoredBinaryTrees(int[] nums) {
        Arrays.sort(nums);
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            map.put(nums[i], i);
        }
        int MOD = 1000000007;
        int[] dp = new int[nums.length];
        Arrays.fill(dp, 1);
        for (int i = 0; i < nums.length; i++) {
            for (int j = 0; j < i; j++) {
                if (nums[i] % nums[j] == 0) {
                    int factor = nums[i] / nums[j];
                    if (map.containsKey(factor)) {
                        int index = map.get(factor);
                        dp[i] = (dp[i] + dp[j] * dp[index]) % MOD;
                    }
                }
            }
        }
        int result = 0;
        for (int val : dp) {
            result = (result + val) % MOD;
        }
        return result;
    }
}
}