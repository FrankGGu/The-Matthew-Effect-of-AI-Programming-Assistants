import java.util.Arrays;

class Solution {
    private static final int MOD = 1_000_000_007;

    private long power(long base, long exp) {
        long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    public int sumOfPower(int[] nums, int k) {
        Arrays.sort(nums);

        // dp[val] stores the total count of subsequences whose maximum element is 'val'.
        // This is a cumulative count across all processed elements.
        long[] dp = new long[100001]; // Max value of nums[i] is 10^5

        long totalSumOfKPower = 0;
        // totalSubsequencesCountSoFar stores the sum of dp[x] for all x processed so far.
        // It represents the total count of non-empty subsequences formed from elements processed so far.
        long totalSubsequencesCountSoFar = 0;

        for (int num : nums) {
            long currentNum = num;

            // Calculate the number of new subsequences that include this specific 'currentNum'
            // and have 'currentNum' as their maximum.
            // These new subsequences are:
            // 1. [currentNum] itself (1 subsequence)
            // 2. [S', currentNum] where S' is any non-empty subsequence formed from previously processed elements
            //    such that max(S') <= currentNum.
            // The count of such S' is 'totalSubsequencesCountSoFar'.
            // So, the total number of new subsequences formed with this 'currentNum' as max is (1 + totalSubsequencesCountSoFar).
            long newSubsequencesFormedWithCurrentNumAsMax = (1 + totalSubsequencesCountSoFar) % MOD;

            // Update totalSumOfKPower
            // This 'newSubsequencesFormedWithCurrentNumAsMax' count represents a set of subsequences
            // that are newly formed by including the current 'num'. All these subsequences have 'num' as their maximum.
            // So, they all contribute k^num to the total sum.
            long term = (newSubsequencesFormedWithCurrentNumAsMax * power(k, currentNum)) % MOD;
            totalSumOfKPower = (totalSumOfKPower + term) % MOD;

            // Update dp[currentNum] and totalSubsequencesCountSoFar.
            // The 'newSubsequencesFormedWithCurrentNumAsMax' count is added to dp[currentNum]
            // because these are new subsequences whose maximum is 'currentNum'.
            // This also means 'totalSubsequencesCountSoFar' (sum of all dp values) needs to be updated.
            dp[(int)currentNum] = (dp[(int)currentNum] + newSubsequencesFormedWithCurrentNumAsMax) % MOD;
            totalSubsequencesCountSoFar = (totalSubsequencesCountSoFar + newSubsequencesFormedWithCurrentNumAsMax) % MOD;
        }

        return (int) totalSumOfKPower;
    }
}