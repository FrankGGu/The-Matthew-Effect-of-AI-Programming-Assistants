class Solution {
    public int sumSubseqWidths(int[] A) {
        Arrays.sort(A);
        long result = 0, mod = 1000000007;
        long pow = 1;
        for (int i = 0; i < A.length; i++) {
            result = (result + (A[i] * pow) % mod) % mod;
            pow = (pow * 2) % mod;
        }
        pow = 1;
        for (int i = A.length - 1; i >= 0; i--) {
            result = (result - (A[i] * pow) % mod + mod) % mod;
            pow = (pow * 2) % mod;
        }
        return (int) result;
    }
}