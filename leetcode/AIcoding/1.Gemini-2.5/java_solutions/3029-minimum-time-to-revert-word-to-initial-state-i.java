class Solution {
    // Prime base for hashing. A small prime like 31 is common for lowercase English letters.
    private static final long P = 31;
    // Modulus for hashing. A large prime number to reduce collisions.
    private static final long M = 1_000_000_007;

    public int minimumTimeToRevertWord(String word, int k) {
        int n = word.length();

        // Precompute powers of P modulo M.
        // p_pow[i] will store P^i % M.
        // We need powers up to 2*n because doubleWord has length 2*n.
        long[] p_pow = new long[2 * n + 1];
        p_pow[0] = 1;
        for (int i = 1; i <= 2 * n; i++) {
            p_pow[i] = (p_pow[i - 1] * P) % M;
        }

        // Create the doubled string (word + word) to easily handle cyclic shifts.
        // For example, if word="abc", doubleWord="abcabc".
        // A cyclic shift of "abc" by 1 is "bca", which is doubleWord.substring(1, 1+3).
        String doubleWord = word + word;

        // Precompute prefix hashes for doubleWord.
        // hashes[i] will store the hash of doubleWord.substring(0, i).
        // The hash is calculated as (c_0 * P^(i-1) + c_1 * P^(i-2) + ... + c_{i-1} * P^0) % M.
        long[] hashes = new long[2 * n + 1];
        hashes[0] = 0; // Hash of an empty string
        for (int i = 0; i < 2 * n; i++) {
            // Character value: 'a' -> 1, 'b' -> 2, ..., 'z' -> 26
            hashes[i + 1] = (hashes[i] * P + (doubleWord.charAt(i) - 'a' + 1)) % M;
        }

        // Calculate the hash of the original word. This is our target hash.
        long targetHash = 0;
        for (int i = 0; i < n; i++) {
            targetHash = (targetHash * P + (word.charAt(i) - 'a' + 1)) % M;
        }

        // Iterate through possible number of operations 't'.
        // 't' can range from 1 to n.
        // After 'n' operations, the word will always revert to its initial state
        // because the total shift will be n*k, which modulo n is 0.
        for (int t = 1; t <= n; t++) {
            // The total number of characters shifted is t * k.
            // Since we're dealing with cyclic shifts of a string of length n,
            // the effective starting position in 'doubleWord' is (t * k) % n.
            // Using long for (long)t * k to prevent overflow before modulo, as t*k can be up to 10^5 * 10^5 = 10^10.
            int effectiveShift = (int)(((long)t * k) % n);

            // Calculate the hash of the substring of doubleWord starting at effectiveShift
            // and having length n.
            // The formula for substring hash (s[start...end-1]) is:
            // (hashes[end] - (hashes[start] * p_pow[end - start]) % M + M) % M
            // Here, start = effectiveShift, end = effectiveShift + n, length = n.
            long currentSubHash = (hashes[effectiveShift + n] - (hashes[effectiveShift] * p_pow[n]) % M + M) % M;

            // If the hash of the current shifted word matches the target hash,
            // we have found the minimum number of operations.
            // In competitive programming, comparing hashes is usually sufficient.
            // For absolute certainty (to avoid rare hash collisions), one could
            // perform a full string comparison:
            // if (currentSubHash == targetHash && word.equals(doubleWord.substring(effectiveShift, effectiveShift + n)))
            if (currentSubHash == targetHash) {
                return t;
            }
        }

        // This line should theoretically not be reached because the loop will always find a match
        // by t=n (as effectiveShift will be 0, matching the original word).
        return n; 
    }
}