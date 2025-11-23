import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minChanges(int[] nums, int k) {
        int n = nums.length;
        int[] dp = new int[1024];
        for (int i = 0; i < 1024; i++) {
            dp[i] = n;
        }
        dp[0] = 0;

        for (int i = 0; i < k; i++) {
            Map<Integer, Integer> count = new HashMap<>();
            int cost = 0;
            for (int j = i; j < n; j += k) {
                count.put(nums[j], count.getOrDefault(nums[j], 0) + 1);
                cost++;
            }

            int minCost = Integer.MAX_VALUE;
            for (int val : count.values()) {
                minCost = Math.min(minCost, cost - val);
            }

            int[] newDp = new int[1024];
            for (int j = 0; j < 1024; j++) {
                newDp[j] = dp[j] + minCost;
            }

            for (int xor = 0; xor < 1024; xor++) {
                for (int num : count.keySet()) {
                    newDp[xor] = Math.min(newDp[xor], dp[xor ^ num] + cost - count.get(num));
                }
            }

            dp = newDp;
        }

        return dp[0];
    }
}