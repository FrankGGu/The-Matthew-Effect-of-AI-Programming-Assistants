class Solution {
    public long getMaxFunctionValue(int[] receiver, long k) {
        int n = receiver.length;
        int maxJ = 0;
        if (k > 0) {
            maxJ = (int) (Math.log(k) / Math.log(2));
        }
        // A safe upper bound for maxJ for k up to 10^9 is 30 or 31.
        // 2^29 < 10^9 < 2^30. So 30 is sufficient for k.
        // Using 31 to cover up to 2^30 jumps.
        maxJ = 30; 

        int[][] dp = new int[maxJ + 1][n]; // dp[j][i] = person after 2^j passes from i
        long[][] pathSum = new long[maxJ + 1][n]; // pathSum[j][i] = sum of p_0 + ... + p_{2^j-1} starting from i

        // Base case: j = 0 (1 pass, represents the first person in the sequence)
        for (int i = 0; i < n; i++) {
            dp[0][i] = receiver[i];
            pathSum[0][i] = i; // Value of p_0
        }

        // Fill dp and pathSum tables for j > 0
        for (int j = 1; j <= maxJ; j++) {
            for (int i = 0; i < n; i++) {
                dp[j][i] = dp[j-1][dp[j-1][i]];
                pathSum[j][i] = pathSum[j-1][i] + pathSum[j-1][dp[j-1][i]];
            }
        }

        long maxTotalValue = 0;

        // Iterate through all possible starting persons x
        for (int x = 0; x < n; x++) {
            long currentTotalValue = 0;
            int currentPerson = x;
            long tempK = k; 

            for (int j = maxJ; j >= 0; j--) {
                if (((tempK >> j) & 1) == 1) { // If j-th bit of k is set
                    currentTotalValue += pathSum[j][currentPerson];
                    currentPerson = dp[j][currentPerson];
                }
            }
            // After k passes, currentPerson is p_k.
            // currentTotalValue contains p_0 + ... + p_{k-1}.
            // Add p_k to get the full sum: p_0 + ... + p_k.
            currentTotalValue += currentPerson;
            maxTotalValue = Math.max(maxTotalValue, currentTotalValue);
        }

        return maxTotalValue;
    }
}