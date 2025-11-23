import java.util.HashSet;
import java.util.Set;

class Solution {
    public int beautifulPartitions(int[] nums, int k, int minLength) {
        int n = nums.length;
        if (nums[0] % 2 == 0 || nums[n - 1] % 2 != 0 || n < minLength * k) {
            return 0;
        }

        Set<Integer> primes = new HashSet<>();
        primes.add(2);
        primes.add(3);
        primes.add(5);
        primes.add(7);

        int[][] dp = new int[n + 1][k + 1];
        dp[0][0] = 1;
        int mod = 1000000007;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                for (int l = minLength; l <= i; l++) {
                    if (i - l >= 0 && primes.contains(nums[i - l])) {
                        dp[i][j] = (dp[i][j] + dp[i - l][j - 1]) % mod;
                    }
                }
            }
        }

        return dp[n][k];
    }
}