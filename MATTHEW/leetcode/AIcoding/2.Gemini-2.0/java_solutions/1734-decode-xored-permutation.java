class Solution {
    public int[] decode(int[] encoded, int n) {
        int[] perm = new int[n];
        int xorSum = 0;
        for (int i = 1; i <= n; i++) {
            xorSum ^= i;
        }

        int encodedXorSum = 0;
        for (int i = 1; i < n - 1; i += 2) {
            encodedXorSum ^= encoded[i];
        }

        perm[0] = xorSum ^ encodedXorSum;

        for (int i = 1; i < n; i++) {
            perm[i] = perm[i - 1] ^ encoded[i - 1];
        }

        return perm;
    }
}