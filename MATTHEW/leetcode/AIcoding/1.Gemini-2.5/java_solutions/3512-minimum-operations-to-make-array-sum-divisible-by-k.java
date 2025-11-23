import java.util.Arrays;

class Solution {
    public int minOperations(int[] nums, int k) {
        long initialSum = 0;
        for (int num : nums) {
            initialSum += num;
        }

        int targetRemainder = (int)(initialSum % k);

        if (targetRemainder == 0) {
            return 0;
        }

        // dp[r] will store the minimum number of elements whose sum modulo k is r.
        // Initialize with a value greater than nums.length, representing infinity.
        int[] dp = new int[k];
        int N = nums.length;
        Arrays.fill(dp, N + 1);
        dp[0] = 0; // 0 elements sum to 0 (mod k)

        for (int num : nums) {
            int val = num % k;
            // Iterate in reverse to use dp values from the previous iteration (before considering current num)
            for (int r = k - 1; r >= 0; r--) {
                if (dp[r] < N + 1) { // If remainder r is reachable
                    int newRem = (r + val) % k;
                    dp[newRem] = Math.min(dp[newRem], dp[r] + 1);
                }
            }
        }

        int result = dp[targetRemainder];

        if (result == N + 1) {
            return -1; // Impossible to achieve targetRemainder by removing a subset
        } else {
            return result;
        }
    }
}