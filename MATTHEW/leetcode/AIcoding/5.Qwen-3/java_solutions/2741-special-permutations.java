public class Solution {

import java.util.*;

public class Solution {
    public int specialPermutations(int[] nums) {
        int n = nums.length;
        int[][] dp = new int[1 << n][n];
        for (int i = 0; i < n; i++) {
            dp[1 << i][i] = 1;
        }

        for (int mask = 0; mask < (1 << n); mask++) {
            for (int last = 0; last < n; last++) {
                if ((mask & (1 << last)) == 0) continue;
                for (int next = 0; next < n; next++) {
                    if ((mask & (1 << next)) != 0) continue;
                    if (nums[next] % nums[last] == 0) {
                        dp[mask | (1 << next)][next] += dp[mask][last];
                    }
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            result += dp[(1 << n) - 1][i];
        }
        return result;
    }
}
}