import java.util.Arrays;

class Solution {
    private static final int MOD = 1_000_000_007;

    public int sumOfPower(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;

        long totalPower = 0;

        long inv2 = power(2, MOD - 2);

        long sumValDivPow2 = 0;

        long currentPow2 = 1; 

        long currentInvPow2 = 1;

        for (int i = 0; i < n; i++) {
            long num_i = nums[i];

            long termSingleElement = (num_i * num_i) % MOD;
            termSingleElement = (termSingleElement * num_i) % MOD;
            totalPower = (totalPower + termSingleElement) % MOD;

            if (i > 0) {
                long valForMultiple = (num_i * num_i) % MOD;
                valForMultiple = (valForMultiple * inv2) % MOD;
                valForMultiple = (valForMultiple * currentPow2) % MOD;
                valForMultiple = (valForMultiple * sumValDivPow2) % MOD;

                totalPower = (totalPower + valForMultiple) % MOD;
            }

            long termToAdd = (num_i * currentInvPow2) % MOD;
            sumValDivPow2 = (sumValDivPow2 + termToAdd) % MOD;

            currentPow2 = (currentPow2 * 2) % MOD;
            currentInvPow2 = (currentInvPow2 * inv2) % MOD;
        }

        return (int) totalPower;
    }

    private long power(long base, long exp) {
        long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }
}