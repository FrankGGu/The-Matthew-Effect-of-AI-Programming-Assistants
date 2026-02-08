import java.util.Arrays;

public class Solution {
    public int minimumIncompatibility(int[] nums, int k) {
        int n = nums.length;
        int groupSize = n / k;
        int[][] dp = new int[1 << n][k + 1];
        int[] groupIncompatibility = new int[1 << n];

        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0][0] = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            for (int j = 0; j < k; j++) {
                if (dp[mask][j] == Integer.MAX_VALUE) continue;
                int currentMask = mask, count = 0, min = Integer.MAX_VALUE, max = Integer.MIN_VALUE;
                for (int i = 0; i < n; i++) {
                    if ((mask & (1 << i)) == 0) {
                        count++;
                        currentMask |= (1 << i);
                        min = Math.min(min, nums[i]);
                        max = Math.max(max, nums[i]);
                    }
                    if (count == groupSize) break;
                }
                if (count == groupSize) {
                    int incompatibility = max - min;
                    int nextMask = currentMask;
                    groupIncompatibility[nextMask] = incompatibility;
                    dp[nextMask][j + 1] = Math.min(dp[nextMask][j + 1], dp[mask][j] + incompatibility);
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int mask = 0; mask < (1 << n); mask++) {
            if (Integer.bitCount(mask) == n) {
                result = Math.min(result, dp[mask][k]);
            }
        }
        return result == Integer.MAX_VALUE ? -1 : result;
    }
}