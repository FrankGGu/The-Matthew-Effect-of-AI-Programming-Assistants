class Solution {
    public int numberOfArrays(String s, int k) {
        int n = s.length();
        int MOD = 1_000_000_007;
        int[] dp = new int[n + 1];
        dp[n] = 1;

        for (int i = n - 1; i >= 0; i--) {
            if (s.charAt(i) == '0') {
                continue;
            }

            long currentNum = 0;
            for (int j = i; j < n; j++) {
                currentNum = currentNum * 10 + (s.charAt(j) - '0');

                if (currentNum > k) {
                    break; 
                }

                dp[i] = (dp[i] + dp[j + 1]) % MOD;
            }
        }

        return dp[0];
    }
}