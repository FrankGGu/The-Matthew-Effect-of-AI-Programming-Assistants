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

    public int findNumberOfCopyArrays(int[] nums, int k) {
        int countK = 0;
        int countKMinus1 = 0;
        int countLessThanKMinus1 = 0;

        for (int num : nums) {
            if (num > k) {
                return 0;
            }
            if (num == k) {
                countK++;
            } else if (num == k - 1) {
                countKMinus1++;
            } else {
                countLessThanKMinus1++;
            }
        }

        long totalWaysLeK = power(2, countKMinus1 + countLessThanKMinus1);

        long waysLtK;
        if (countK > 0) {
            waysLtK = 0;
        } else {
            waysLtK = power(2, countLessThanKMinus1);
        }

        long result = (totalWaysLeK - waysLtK + MOD) % MOD;
        return (int) result;
    }
}