class Solution {
    public int nthSuperUglyNumber(int n, int[] primes) {
        int[] dp = new int[n];
        dp[0] = 1;

        int[] pointers = new int[primes.length]; // Pointers for each prime, initialized to 0

        for (int i = 1; i < n; i++) {
            int minVal = Integer.MAX_VALUE;

            // Find the minimum candidate for the next ugly number
            for (int j = 0; j < primes.length; j++) {
                minVal = Math.min(minVal, dp[pointers[j]] * primes[j]);
            }
            dp[i] = minVal;

            // Advance pointers for all primes that generated the minVal
            for (int j = 0; j < primes.length; j++) {
                if (dp[pointers[j]] * primes[j] == minVal) {
                    pointers[j]++;
                }
            }
        }

        return dp[n - 1];
    }
}