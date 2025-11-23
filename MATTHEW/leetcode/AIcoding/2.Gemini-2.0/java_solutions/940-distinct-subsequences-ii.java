class Solution {
    public int distinctSubseqII(String s) {
        int mod = 1000000007;
        int[] dp = new int[26];
        int sum = 0;
        for (char c : s.toCharArray()) {
            int index = c - 'a';
            int prev = dp[index];
            dp[index] = (sum + 1) % mod;
            sum = (sum + dp[index] - prev + mod) % mod;
        }
        return sum;
    }
}