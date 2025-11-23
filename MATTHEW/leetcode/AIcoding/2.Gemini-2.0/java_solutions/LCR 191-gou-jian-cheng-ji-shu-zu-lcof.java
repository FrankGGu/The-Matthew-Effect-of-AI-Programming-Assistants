import java.util.*;

class Solution {
    public int countWays(List<String> s) {
        int n = s.size();
        int mod = 1000000007;
        long[] dp = new long[2];
        dp[0] = 1;
        dp[1] = 0;

        for (int i = 0; i < n; i++) {
            String str = s.get(i);
            long[] newDp = new long[2];
            if (str.equals("AND")) {
                newDp[0] = dp[0];
                newDp[1] = (dp[0] + dp[1]) % mod;
            } else if (str.equals("OR")) {
                newDp[0] = (dp[0] + dp[1]) % mod;
                newDp[1] = dp[1];
            } else {
                newDp[0] = (dp[0] + dp[1]) % mod;
                newDp[1] = (dp[0] + dp[1]) % mod;
            }
            dp = newDp;
        }

        return (int) dp[1];
    }
}