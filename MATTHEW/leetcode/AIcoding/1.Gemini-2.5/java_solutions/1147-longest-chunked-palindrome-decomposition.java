class Solution {

    private static final long P1 = 31; // A prime base for hash function 1
    private static final long M1 = 1_000_000_007; // A large prime modulus for hash function 1
    private static final long P2 = 37; // A prime base for hash function 2
    private static final long M2 = 1_000_000_009; // A large prime modulus for hash function 2

    private long[] p_pow1; // Stores powers of P1 modulo M1
    private long[] p_pow2; // Stores powers of P2 modulo M2
    private long[] h1; // h1[i] stores hash of text[0...i-1] using P1, M1
    private long[] h2; // h2[i] stores hash of text[0...i-1] using P2, M2
    private int N; // Length of the input string
    private String text; // The input string

    // Precomputes powers of bases and prefix hashes for the given text
    private void precomputeHashes() {
        N = text.length();
        p_pow1 = new long[N + 1];
        p_pow2 = new long[N + 1];
        h1 = new long[N + 1];
        h2 = new long[N + 1];

        // Precompute powers of P1 and P2
        p_pow1[0] = 1;
        p_pow2[0] = 1;
        for (int i = 1; i <= N; i++) {
            p_pow1[i] = (p_pow1[i - 1] * P1) % M1;
            p_pow2[i] = (p_pow2[i - 1] * P2) % M2;
        }

        // Precompute prefix hashes
        // h[i] stores hash of text[0...i-1]
        // Character values are mapped to 1-26 for 'a'-'z'
        h1[0] = 0;
        h2[0] = 0;
        for (int i = 0; i < N; i++) {
            h1[i + 1] = (h1[i] * P1 + (text.charAt(i) - 'a' + 1)) % M1;
            h2[i + 1] = (h2[i] * P2 + (text.charAt(i) - 'a' + 1)) % M2;
        }
    }

    // Returns the hash value of the substring text[start...end] (inclusive)
    // using P1 and M1
    private long getHash1(int start, int end) {
        // Hash of text[start...end] = h1[end+1] - h1[start] * P1^(length)
        // Ensure positive result with ( + M1) % M1
        long hash = (h1[end + 1] - (h1[start] * p_pow1[end - start + 1]) % M1 + M1) % M1;
        return hash;
    }

    // Returns the hash value of the substring text[start...end] (inclusive)
    // using P2 and M2
    private long getHash2(int start, int end) {
        // Hash of text[start...end] = h2[end+1] - h2[start] * P2^(length)
        // Ensure positive result with ( + M2) % M2
        long hash = (h2[end + 1] - (h2[start] * p_pow2[end - start + 1]) % M2 + M2) % M2;
        return hash;
    }

    public int longestDecomposition(String text) {
        this.text = text;
        precomputeHashes();

        int left = 0; // Left pointer for the current segment of text
        int right = N - 1; // Right pointer for the current segment of text
        int ans = 0; // Total count of chunks

        // The main greedy loop
        while (left <= right) {
            // If only one character or an empty segment remains
            if (left == right) {
                ans += 1; // This single character forms one chunk
                break;
            }

            boolean foundMatch = false;
            // Iterate 'len' from 1 up to half the length of the current segment
            // We look for the smallest 'len' such that prefix of length 'len' matches suffix of length 'len'
            // The condition 'left + len - 1 < right - len + 1' ensures the prefix and suffix do not overlap
            for (int len = 1; left + len - 1 < right - len + 1; len++) {
                // Get hashes for the prefix and suffix of current length 'len'
                long prefixHash1 = getHash1(left, left + len - 1);
                long prefixHash2 = getHash2(left, left + len - 1);

                long suffixHash1 = getHash1(right - len + 1, right);
                long suffixHash2 = getHash2(right - len + 1, right);

                // If both hash functions agree, we consider it a match
                if (prefixHash1 == suffixHash1 && prefixHash2 == suffixHash2) {
                    ans += 2; // Found two chunks
                    left += len; // Move left pointer past the matched prefix
                    right -= len; // Move right pointer before the matched suffix
                    foundMatch = true;
                    break; // Break from inner loop to process the remaining middle segment
                }
            }

            // If no matching prefix/suffix pair was found for the current segment
            if (!foundMatch) {
                ans += 1; // The entire remaining segment forms one chunk
                break; // No further decomposition possible for this segment
            }
        }

        return ans;
    }
}