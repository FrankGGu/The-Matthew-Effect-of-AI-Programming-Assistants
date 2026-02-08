class Solution {
    public int findIntegers(int n) {
        int[] dp = new int[32];
        dp[0] = 1;
        dp[1] = 2;
        for (int i = 2; i < 32; i++) {
            dp[i] = dp[i - 1] + dp[i - 2];
        }
        int res = 0;
        int prevBit = 0;
        for (int i = 30; i >= 0; i--) {
            if ((n & (1 << i)) != 0) {
                res += dp[i];
                if (prevBit == 1) {
                    res--;
                    break;
                }
                prevBit = 1;
            } else {
                prevBit = 0;
            }
        }
        return res + 1;
    }
}