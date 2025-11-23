public class Solution {

import java.util.*;

public class Solution {
    public int minIncompatity(int[] nums, int k) {
        int n = nums.length;
        if (n % k != 0) return -1;
        int m = n / k;
        Arrays.sort(nums);
        int[][] dp = new int[1 << n][k];
        for (int i = 0; i < (1 << n); i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }
        dp[0][k - 1] = 0;
        for (int mask = 0; mask < (1 << n); mask++) {
            for (int i = 0; i < k; i++) {
                if (dp[mask][i] == Integer.MAX_VALUE) continue;
                int cnt = 0;
                for (int j = 0; j < n; j++) {
                    if ((mask & (1 << j)) != 0) cnt++;
                }
                if (cnt == m) {
                    if (i == k - 1) continue;
                    dp[mask][i + 1] = Math.min(dp[mask][i + 1], dp[mask][i]);
                    continue;
                }
                for (int j = 0; j < n; j++) {
                    if ((mask & (1 << j)) == 0) {
                        int nextMask = mask | (1 << j);
                        int currentIncomp = dp[mask][i];
                        if (currentIncomp == Integer.MAX_VALUE) continue;
                        int max = nums[j];
                        int min = nums[j];
                        for (int l = 0; l < n; l++) {
                            if ((mask & (1 << l)) != 0) {
                                max = Math.max(max, nums[l]);
                                min = Math.min(min, nums[l]);
                            }
                        }
                        int incomp = max - min;
                        dp[nextMask][i] = Math.min(dp[nextMask][i], currentIncomp + incomp);
                    }
                }
            }
        }
        int result = dp[(1 << n) - 1][k - 1];
        return result == Integer.MAX_VALUE ? -1 : result;
    }
}
}