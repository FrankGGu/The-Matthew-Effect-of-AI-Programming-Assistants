class Solution {
    public int minKBitFlips(int[] A, int K) {
        int flips = 0, n = A.length, flipCount = 0;
        int[] flip = new int[n + 1];

        for (int i = 0; i < n; i++) {
            flipCount ^= flip[i];
            if ((A[i] ^ flipCount) == 0) {
                if (i + K > n) return -1;
                flips++;
                flipCount ^= 1;
                if (i + K < n) flip[i + K] ^= 1;
            }
        }

        return flips;
    }
}