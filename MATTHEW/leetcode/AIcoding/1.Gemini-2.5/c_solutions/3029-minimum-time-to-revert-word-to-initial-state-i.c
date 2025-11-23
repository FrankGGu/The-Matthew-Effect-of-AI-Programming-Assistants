#include <string.h>
#include <stdlib.h> // For malloc, free

#define P1 31
#define M1 1000000007

#define P2 37
#define M2 1000000009

long long get_substring_hash(long long *h_arr, long long *p_pow_arr, int start, int len, int M) {
    if (len == 0) return 0;
    long long val = h_arr[start + len] - (h_arr[start] * p_pow_arr[len]) % M;
    return (val + M) % M;
}

int minimumTimeToRevert(char *word, int k) {
    int n = strlen(word);

    // Dynamic allocation for powers and prefix hashes
    // +1 for 0-th power/hash, +1 for n-th hash
    long long *p_pow1 = (long long *)malloc(sizeof(long long) * (n + 1));
    long long *p_pow2 = (long long *)malloc(sizeof(long long) * (n + 1));
    long long *h1 = (long long *)malloc(sizeof(long long) * (n + 1));
    long long *h2 = (long long *)malloc(sizeof(long long) * (n + 1));

    p_pow1[0] = 1;
    p_pow2[0] = 1;
    h1[0] = 0;
    h2[0] = 0;

    for (int i = 0; i < n; i++) {
        p_pow1[i + 1] = (p_pow1[i] * P1) % M1;
        p_pow2[i + 1] = (p_pow2[i] * P2) % M2;

        h1[i + 1] = (h1[i] * P1 + (word[i] - 'a' + 1)) % M1;
        h2[i + 1] = (h2[i] * P2 + (word[i] - 'a' + 1)) % M2;
    }

    long long original_hash1 = get_substring_hash(h1, p_pow1, 0, n, M1);
    long long original_hash2 = get_substring_hash(h2, p_pow2, 0, n, M2);

    for (int t = 1; t <= n; t++) {
        // The effective shift after t operations
        // The string becomes word[t*k ... n-1] + word[0 ... t*k - 1]
        // This is equivalent to word rotated left by (t*k) positions.
        // The effective rotation amount is (t*k) % n.
        int effective_offset = (int)(((long long)t * k) % n);

        long long current_hash1;
        long long current_hash2;

        if (effective_offset == 0) {
            // If effective_offset is 0, the string is the same as the original
            current_hash1 = original_hash1;
            current_hash2 = original_hash2;
        } else {
            // The shifted string consists of two parts:
            // 1. Suffix of original word: word[effective_offset ... n-1]
            // 2. Prefix of original word: word[0 ... effective_offset-1]
            int len1 = n - effective_offset; // Length of the suffix part
            int len2 = effective_offset;     // Length of the prefix part

            // Calculate hash for the first part (suffix)
            long long hash_part1_1 = get_substring_hash(h1, p_pow1, effective_offset, len1, M1);
            long long hash_part1_2 = get_substring_hash(h2, p_pow2, effective_offset, len1, M2);

            // Calculate hash for the second part (prefix)
            long long hash_part2_1 = get_substring_hash(h1, p_pow1, 0, len2, M1);
            long long hash_part2_2 = get_substring_hash(h2, p_pow2, 0, len2, M2);

            // Combine hashes: hash_part1 * P^len2 + hash_part2
            // This combines the hash of the first part (suffix) shifted left by len2 positions
            // with the hash of the second part (prefix).
            current_hash1 = (hash_part1_1 * p_pow1[len2] + hash_part2_1) % M1;
            current_hash2 = (hash_part1_2 * p_pow2[len2] + hash_part2_2) % M2;
        }

        if (current_hash1 == original_hash1 && current_hash2 == original_hash2) {
            // Free allocated memory before returning
            free(p_pow1);
            free(p_pow2);
            free(h1);
            free(h2);
            return t;
        }
    }

    // This line should theoretically not be reached as t=n always results in the original string.
    // However, as a fallback and to ensure memory is freed.
    free(p_pow1);
    free(p_pow2);
    free(h1);
    free(h2);
    return n; 
}