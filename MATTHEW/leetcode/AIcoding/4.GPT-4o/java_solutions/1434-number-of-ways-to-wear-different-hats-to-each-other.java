import java.util.*;

public class Solution {
    private static final int MOD = 1000000007;

    public int numberOfWays(int[][] hats) {
        int n = hats.length;
        int maxHat = 0;
        for (int[] person : hats) {
            for (int hat : person) {
                maxHat = Math.max(maxHat, hat);
            }
        }

        int[][] dp = new int[1 << n][maxHat + 1];
        dp[0][0] = 1;

        for (int hat = 1; hat <= maxHat; hat++) {
            for (int mask = 0; mask < (1 << n); mask++) {
                dp[mask][hat] = dp[mask][hat - 1];
                for (int person = 0; person < n; person++) {
                    if (hats[person][0] == hat) {
                        if ((mask & (1 << person)) == 0) {
                            dp[mask | (1 << person)][hat] = (dp[mask | (1 << person)][hat] + dp[mask][hat - 1]) % MOD;
                        }
                    }
                }
            }
        }

        int result = 0;
        for (int mask = 1; mask < (1 << n); mask++) {
            result = (result + dp[mask][maxHat]) % MOD;
        }

        return result;
    }
}