class Solution {
    public int countGoodArrays(int[] nums) {
        int MOD = 1_000_000_007;
        long count = 1;
        long gcd = 0;

        for (int num : nums) {
            gcd = gcd(gcd, num);
        }

        for (int num : nums) {
            if (gcd != 1) {
                count = (count * (num / gcd)) % MOD;
            }
        }

        return (int)count;
    }

    private long gcd(long a, long b) {
        while (b != 0) {
            long temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}