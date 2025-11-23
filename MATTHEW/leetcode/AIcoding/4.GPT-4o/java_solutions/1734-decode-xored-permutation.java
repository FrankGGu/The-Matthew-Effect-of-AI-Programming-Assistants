class Solution {
    public int[] decode(int[] encoded) {
        int n = encoded.length + 1;
        int[] perm = new int[n];
        int totalXor = 0;
        for (int i = 1; i <= n; i++) {
            totalXor ^= i;
        }
        int xorEncoded = 0;
        for (int i = 1; i < n - 1; i += 2) {
            xorEncoded ^= encoded[i];
        }
        perm[0] = totalXor ^ xorEncoded;
        for (int i = 1; i < n; i++) {
            perm[i] = perm[i - 1] ^ encoded[i - 1];
        }
        return perm;
    }
}