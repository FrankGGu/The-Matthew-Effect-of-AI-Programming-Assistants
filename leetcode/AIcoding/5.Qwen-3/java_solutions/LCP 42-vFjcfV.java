public class Solution {
    public int findIntegers(int n) {
        int[] dp = new int[32];
        dp[0] = 1;
        dp[1] = 2;
        for (int i = 2; i < 32; i++) {
            dp[i] = dp[i - 1] + dp[i - 2];
        }
        int res = 0;
        int prev = 1;
        int i = 30;
        while (i >= 0) {
            if ((n & (1 << i)) != 0) {
                res += dp[i];
                if (prev == 1) {
                    res--;
                    break;
                }
            }
            prev = (n & (1 << i)) != 0 ? 1 : 0;
            i--;
        }
        return res + 1;
    }
}