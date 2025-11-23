public class Solution {

import java.util.*;

public class Solution {
    public int numWays(int[] nums, int k) {
        int n = nums.length;
        if (n == 0 || k == 0) return 0;
        if (k == 1) return 1;
        if (nums[0] == 1 || nums[n - 1] == 1) return 0;

        int MOD = 1000000007;

        boolean[] isVowel = new boolean[n];
        for (int i = 0; i < n; i++) {
            isVowel[i] = nums[i] == 1;
        }

        int[][] dp = new int[k + 1][n];
        for (int i = 0; i < n; i++) {
            if (isVowel[i]) {
                dp[1][i] = 1;
            }
        }

        for (int t = 2; t <= k; t++) {
            for (int i = 0; i < n; i++) {
                if (!isVowel[i]) continue;
                for (int j = 0; j < i; j++) {
                    if (!isVowel[j]) continue;
                    dp[t][i] = (dp[t][i] + dp[t - 1][j]) % MOD;
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            result = (result + dp[k][i]) % MOD;
        }
        return result;
    }
}
}