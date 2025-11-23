import java.util.Arrays;

class Solution {

    // Using two hash functions to reduce collision probability
    private static final long M1 = 1_000_000_007L;
    private static final long M2 = 1_000_000_009L;
    private static final long P1 = 31L; // Base for first hash
    private static final long P2 = 37L; // Base for second hash

    private long[] pow1;
    private long[] pow2;
    private long[] hashFwd1; // hashFwd1[i] stores hash of s[0...i-1]
    private long[] hashFwd2; // hashFwd2[i] stores hash of s[0...i-1]
    private long[] hashRev1; // hashRev1[i] stores hash of s[i-1...0] (s[i-1]s[i-2]...s[0])
    private long[] hashRev2; // hashRev2[i] stores hash of s[i-1...0] (s[i-1]s[i-2]...s[0])

    private void precomputeHashes(String s, int n) {
        pow1 = new long[n + 1];
        pow2 = new long[n + 1];
        hashFwd1 = new long[n + 1];
        hashFwd2 = new long[n + 1];
        hashRev1 = new long[n + 1];
        hashRev2 = new long[n + 1];

        pow1[0] = 1;
        pow2[0] = 1;

        for (int i = 1; i <= n; i++) {
            pow1[i] = (pow1[i - 1] * P1) % M1;
            pow2[i] = (pow2[i - 1] * P2) % M2;
        }

        for (int i = 0; i < n; i++) {
            int charVal = s.charAt(i) - '0' + 1; // Map '0' to 1, '1' to 2

            // Forward hash for s[0...i]
            hashFwd1[i + 1] = (hashFwd1[i] * P1 + charVal) % M1;
            hashFwd2[i + 1] = (hashFwd2[i] * P2 + charVal) % M2;

            // Reverse hash for s[i...0] (s[i]s[i-1]...s[0])
            hashRev1[i + 1] = (hashRev1[i] + charVal * pow1[i]) % M1;
            hashRev2[i + 1] = (hashRev2[i] + charVal * pow2[i]) % M2;
        }
    }

    // Checks if s[0...len-1] is a palindrome using precomputed hashes
    private boolean isPalindrome(int len) {
        if (len == 0) return true;

        long currentFwdHash1 = hashFwd1[len];
        long currentFwdHash2 = hashFwd2[len];

        long currentRevHash1 = hashRev1[len];
        long currentRevHash2 = hashRev2[len];

        return currentFwdHash1 == currentRevHash1 && currentFwdHash2 == currentRevHash2;
    }

    public String shortestBeautifulSubstring(String s, int k) {
        int n = s.length();

        precomputeHashes(s, n);

        int[] prefixSumBadND = new int[n]; 

        // badNDArr[i] = 1 if s[i] > s[i+k], 0 otherwise
        // prefixSumBadND[j] = sum of badNDArr[0]...badNDArr[j]
        // This array is relevant for L > k, so for indices up to n-k-1.
        if (n - k > 0) {
            int[] badNDArr = new int[n - k];
            for (int i = 0; i < n - k; i++) {
                if (s.charAt(i) > s.charAt(i + k)) {
                    badNDArr[i] = 1;
                } else {
                    badNDArr[i] = 0;
                }
            }

            prefixSumBadND[0] = badNDArr[0];
            for (int i = 1; i < n - k; i++) {
                prefixSumBadND[i] = prefixSumBadND[i - 1] + badNDArr[i];
            }
        }

        for (int L = k; L <= n; L += k) {
            // Condition 1: Length is multiple of k (handled by loop L += k)

            // Condition 3: s[i+j*k] <= s[i+(j+1)*k] for 0 <= i < k, 0 <= j < L/k - 1
            // This is equivalent to s[x] <= s[x+k] for 0 <= x < L-k
            // If L=k, then L-k=0, so the range 0 <= x < 0 is empty. Condition is vacuously true.
            if (L > k) {
                // Check sum of badNDArr from 0 to L-k-1
                if (prefixSumBadND[L - k - 1] != 0) {
                    continue; // Non-decreasing condition violated
                }
            }

            // Condition 2: Palindrome
            if (isPalindrome(L)) {
                return s.substring(0, L);
            }
        }

        return ""; // No beautiful string found
    }
}