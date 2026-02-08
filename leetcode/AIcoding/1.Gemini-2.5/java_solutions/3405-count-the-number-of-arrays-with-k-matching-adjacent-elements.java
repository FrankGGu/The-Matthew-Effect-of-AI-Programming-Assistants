class Solution {
    public int numberOfArrays(int n, int m, int k) {
        long MOD = 1_000_000_007;

        // dp[i][j][state]
        // i: current length of the array (1 to n)
        // j: number of matching adjacent elements (0 to k)
        // state:
        //   0: arr[i-1] != arr[i-2] (the last two elements are different)
        //   1: arr[i-1] == arr[i-2] (the last two elements are the same)
        // The values stored are the count of such arrays.
        long[][][] dp = new long[n + 1][k + 1][2];

        // Base case: For an array of length 1
        // An array of length 1 has no adjacent elements, so the count of matching adjacent elements must be 0.
        // The first element can be any of the 'm' values.
        // We consider this initial state as 'different' from a non-existent previous element for the purpose of state transition.
        dp[1][0][0] = m; // m choices for the first element, 0 matches, last is 'different'

        // Iterate for array length from 2 to n
        for (int i = 2; i <= n; i++) {
            // Iterate for number of matching adjacent elements from 0 to k
            for (int j = 0; j <= k; j++) {
                // Calculate dp[i][j][0] (current array of length 'i' has 'j' matches, and arr[i-1] != arr[i-2])
                // To form such an array, the previous array (of length i-1) must also have 'j' matches.
                // The last element of the (i-1)-length array was arr[i-2].
                // We choose arr[i-1] such that arr[i-1] != arr[i-2]. There are (m-1) choices for arr[i-1].
                // It doesn't matter if arr[i-2] was same or different from arr[i-3].
                long waysFromPrevDifferent = dp[i-1][j][0];
                long waysFromPrevSame = dp[i-1][j][1];
                dp[i][j][0] = ((waysFromPrevDifferent + waysFromPrevSame) % MOD * (m - 1)) % MOD;

                // Calculate dp[i][j][1] (current array of length 'i' has 'j' matches, and arr[i-1] == arr[i-2])
                // To form such an array, the previous array (of length i-1) must have (j-1) matches.
                // This is only possible if j > 0 (because we just added a new match).
                if (j > 0) {
                    // The last element of the (i-1)-length array was arr[i-2].
                    // We choose arr[i-1] such that arr[i-1] == arr[i-2]. There is 1 choice for arr[i-1].
                    // It doesn't matter if arr[i-2] was same or different from arr[i-3].
                    waysFromPrevDifferent = dp[i-1][j-1][0];
                    waysFromPrevSame = dp[i-1][j-1][1];
                    dp[i][j][1] = (waysFromPrevDifferent + waysFromPrevSame) % MOD;
                }
            }
        }

        // The final answer is the total number of arrays of length 'n' with exactly 'k' matching adjacent elements.
        // This is the sum of arrays ending with different last two elements and arrays ending with same last two elements.
        return (int)((dp[n][k][0] + dp[n][k][1]) % MOD);
    }
}