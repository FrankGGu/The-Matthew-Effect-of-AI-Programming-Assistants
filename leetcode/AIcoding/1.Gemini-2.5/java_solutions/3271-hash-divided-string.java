class Solution {
    public boolean hashDividedString(String s, int k) {
        int n = s.length();

        if (k == 0) {
            return false;
        }
        if (k == 1) {
            return true;
        }
        if (n == 0) {
            return false;
        }
        if (n % k != 0) {
            return false;
        }

        int segmentLength = n / k;

        long P = 31;
        long M = 1_000_000_007;

        long[] powers = new long[n + 1];
        powers[0] = 1;
        for (int i = 1; i <= n; i++) {
            powers[i] = (powers[i - 1] * P) % M;
        }

        long[] prefixHashes = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixHashes[i + 1] = (prefixHashes[i] * P + (s.charAt(i) - 'a' + 1)) % M;
        }

        long targetHash = (prefixHashes[segmentLength] - (prefixHashes[0] * powers[segmentLength]) % M + M) % M;

        for (int i = 1; i < k; i++) {
            int start = i * segmentLength;
            int end = (i + 1) * segmentLength - 1;

            long currentHash = (prefixHashes[end + 1] - (prefixHashes[start] * powers[segmentLength]) % M + M) % M;

            if (currentHash != targetHash) {
                return false;
            }
        }

        return true;
    }
}