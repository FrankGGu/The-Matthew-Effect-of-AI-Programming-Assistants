class Solution {
    public int totalStrength(int[] strength) {
        int mod = 1_000_000_007;
        int n = strength.length;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = (prefixSum[i] + strength[i]) % mod;
        }

        long[] dp = new long[n + 1];
        long result = 0;
        for (int i = 0; i < n; i++) {
            int left = i, right = i;
            while (left > 0 && strength[left - 1] >= strength[i]) left--;
            while (right < n - 1 && strength[right + 1] > strength[i]) right++;
            long totalStrength = (prefixSum[right + 1] - prefixSum[left] + mod) % mod;
            long count = (i - left + 1) * (right - i + 1) % mod;
            dp[i] = totalStrength * count % mod;
            result = (result + dp[i]) % mod;
        }

        return (int) result;
    }
}