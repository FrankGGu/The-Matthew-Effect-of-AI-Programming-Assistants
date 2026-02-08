class Solution {
    private static final int MOD = 1_000_000_007;

    public int countPartitions(int[] nums) {
        long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        if (totalSum % 2 != 0) {
            return 0;
        }

        int n = nums.length;
        return (int) power(2, n);
    }

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
}