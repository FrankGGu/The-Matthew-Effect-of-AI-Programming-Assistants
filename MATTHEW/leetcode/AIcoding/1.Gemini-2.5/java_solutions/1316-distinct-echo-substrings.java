import java.util.HashSet;
import java.util.Objects;

class Solution {

    // Custom Pair class for storing two hash values, used as keys in HashSet
    static class Pair {
        long h1;
        long h2;

        Pair(long h1, long h2) {
            this.h1 = h1;
            this.h2 = h2;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Pair pair = (Pair) o;
            return h1 == pair.h1 && h2 == pair.h2;
        }

        @Override
        public int hashCode() {
            return Objects.hash(h1, h2);
        }
    }

    // Rabin-Karp hashing parameters
    // Using two sets of prime bases and moduli to reduce collision probability
    private static final long P1 = 31; 
    private static final long M1 = 1_000_000_007; 

    private static final long P2 = 53; 
    private static final long M2 = 1_000_000_009; 

    // Precomputed powers of P1 and P2
    private long[] p_pow1;
    private long[] p_pow2;

    // Precomputed prefix hashes for the input string
    private long[] h1;
    private long[] h2;
    private int N; // Length of the input string

    // Precomputes powers of bases and prefix hashes for the given text
    private void precomputeHashes(String text) {
        N = text.length();
        p_pow1 = new long[N + 1];
        p_pow2 = new long[N + 1];
        h1 = new long[N + 1];
        h2 = new long[N + 1];

        p_pow1[0] = 1;
        p_pow2[0] = 1;
        for (int i = 1; i <= N; i++) {
            p_pow1[i] = (p_pow1[i-1] * P1) % M1;
            p_pow2[i] = (p_pow2[i-1] * P2) % M2;
        }

        for (int i = 0; i < N; i++) {
            // Map 'a' to 1, 'b' to 2, etc., to avoid zero character values
            int charVal = text.charAt(i) - 'a' + 1;
            h1[i+1] = (h1[i] * P1 + charVal) % M1;
            h2[i+1] = (h2[i] * P2 + charVal) % M2;
        }
    }

    // Returns the hash value 1 for the substring text[start...end-1]
    private long getHash1(int start, int end) {
        // (h[end] - h[start] * P^(end-start)) % M
        long val = (h1[end] - (h1[start] * p_pow1[end - start]) % M1 + M1) % M1;
        return val;
    }

    // Returns the hash value 2 for the substring text[start...end-1]
    private long getHash2(int start, int end) {
        long val = (h2[end] - (h2[start] * p_pow2[end - start]) % M2 + M2) % M2;
        return val;
    }

    public int distinctEchoSubstrings(String text) {
        precomputeHashes(text);

        // Use a HashSet to store distinct pairs of hash values for echo substrings
        HashSet<Pair> distinctEchoHashes = new HashSet<>();

        // Iterate through all possible starting positions for the first half of an echo substring
        for (int i = 0; i < N; i++) {
            // Iterate through all possible lengths for the first half
            // The total length of an echo substring is 2 * len
            // So, i + 2 * len must not exceed N
            for (int len = 1; i + 2 * len <= N; len++) {
                // First half: text[i ... i + len - 1]
                // Second half: text[i + len ... i + 2 * len - 1]

                // Calculate hash values for the first half
                long hash1_s1 = getHash1(i, i + len);
                long hash2_s1 = getHash2(i, i + len);

                // Calculate hash values for the second half
                long hash1_s2 = getHash1(i + len, i + 2 * len);
                long hash2_s2 = getHash2(i + len, i + 2 * len);

                // If both hash values match, then the two halves are identical
                // and we've found an echo substring
                if (hash1_s1 == hash1_s2 && hash2_s1 == hash2_s2) {
                    // Add the hash pair of the first half (which is also the hash pair of the second half)
                    // to the set of distinct echo substrings.
                    // We can use either s1's hashes or s2's hashes, as they are identical.
                    distinctEchoHashes.add(new Pair(hash1_s1, hash2_s1));
                }
            }
        }

        // The size of the set gives the number of distinct echo substrings
        return distinctEchoHashes.size();
    }
}