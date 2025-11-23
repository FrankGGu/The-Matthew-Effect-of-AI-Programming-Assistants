import java.util.Arrays;

class Solution {
    private static final int MOD = 1000000007;
    private static final int[] primes = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
    private static final int MAX = 30;

    public int squareFreeSubsets(int[] nums) {
        int[] dp = new int[1 << primes.length];
        dp[0] = 1;
        int ones = 0;

        for (int num : nums) {
            if (num == 1) {
                ones++;
                continue;
            }

            int mask = 0;
            boolean squareFree = true;
            int temp = num;
            for (int i = 0; i < primes.length; i++) {
                if (temp % primes[i] == 0) {
                    if (temp % (primes[i] * primes[i]) == 0) {
                        squareFree = false;
                        break;
                    }
                    mask |= (1 << i);
                }
            }

            if (!squareFree) continue;

            for (int i = (1 << primes.length) - 1; i >= 0; i--) {
                if ((i & mask) == 0) {
                    dp[i | mask] = (dp[i | mask] + dp[i]) % MOD;
                }
            }
        }

        int ans = 0;
        for (int i = 1; i < (1 << primes.length); i++) {
            ans = (ans + dp[i]) % MOD;
        }

        if (ones > 0) {
            long powerOfTwo = 1;
            for (int i = 0; i < ones; i++) {
                powerOfTwo = (powerOfTwo * 2) % MOD;
            }
            ans = (int) (((long) ans * powerOfTwo) % MOD);
            ans = (int) ((ans + powerOfTwo - 1 + MOD) % MOD);
        }

        return ans;
    }
}