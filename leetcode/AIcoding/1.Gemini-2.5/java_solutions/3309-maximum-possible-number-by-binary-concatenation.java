class Solution {
    public int concatenatedBinary(int n) {
        long ans = 0;
        int MOD = 1_000_000_007;

        for (int i = 1; i <= n; i++) {
            int numBits = (Integer.SIZE - Integer.numberOfLeadingZeros(i));
            ans = (ans * (1L << numBits) + i) % MOD;
        }

        return (int) ans;
    }
}