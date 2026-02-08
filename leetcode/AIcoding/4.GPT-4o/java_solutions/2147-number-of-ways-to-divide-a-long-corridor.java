public class Solution {
    public int numberOfWays(String corridor) {
        int n = corridor.length();
        int count = 0;
        for (char c : corridor.toCharArray()) {
            if (c == '|') count++;
        }
        if (count % 2 != 0) return 0;

        int pairs = count / 2;
        long mod = 1000000007;
        long[] dp = new long[pairs + 1];
        dp[0] = 1;

        int lastPipe = -1, pairCount = 0;
        for (int i = 0; i < n; i++) {
            if (corridor.charAt(i) == '|') {
                if (lastPipe != -1 && lastPipe + 1 < i) {
                    dp[pairCount + 1] = (dp[pairCount + 1] + dp[pairCount]) % mod;
                }
                pairCount++;
                lastPipe = i;
            }
        }

        return (int) dp[pairs];
    }
}