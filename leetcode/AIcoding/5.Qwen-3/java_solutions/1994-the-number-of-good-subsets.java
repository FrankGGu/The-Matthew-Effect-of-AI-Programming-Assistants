public class Solution {

import java.util.*;

public class Solution {
    public int numberOfGoodSubsets(int[] nums) {
        int MOD = 1000000007;
        int[] freq = new int[17];
        for (int num : nums) {
            if (num >= 1 && num <= 16) {
                freq[num]++;
            }
        }

        int[] dp = new int[17];
        dp[0] = 1;

        for (int i = 1; i <= 16; i++) {
            if (freq[i] == 0) continue;
            for (int j = 15; j >= 0; j--) {
                if ((j & i) == 0) {
                    dp[j | i] = (dp[j | i] + (long) dp[j] * freq[i]) % MOD;
                }
            }
        }

        int result = 0;
        for (int i = 1; i <= 15; i++) {
            result = (result + dp[i]) % MOD;
        }

        return result;
    }
}
}