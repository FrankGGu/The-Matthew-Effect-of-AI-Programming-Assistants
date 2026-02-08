public class Solution {

import java.util.*;

public class Solution {
    public int firstDayBeenInAllRooms(int[] nextVisit) {
        int n = nextVisit.length;
        int MOD = 1000000007;
        int[] dp = new int[n];
        for (int i = 1; i < n; i++) {
            dp[i] = (dp[i - 1] * 2 - dp[nextVisit[i - 1]] + MOD) % MOD;
        }
        return dp[n - 1];
    }
}
}