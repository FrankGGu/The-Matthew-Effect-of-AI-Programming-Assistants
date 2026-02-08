#include <string.h> // For strlen
#include <stdlib.h> // For long long

char* subStrHash(char* s, int k, int p, int m, long long hashValue) {
    int n = strlen(s);

    // Calculate p^(k-1) % m
    // This will be used to remove the highest power term when sliding the window.
    long long p_pow_k_minus_1 = 1;
    for (int i = 0; i < k - 1; ++i) {
        p_pow_k_minus_1 = (p_pow_k_minus_1 * p) % m;
    }

    long long current_hash = 0;
    long long power_of_p_for_initial_window = 1;

    // Calculate the hash for the rightmost substring of length k: s[n-k ... n-1]
    // The hash is (s[0]*p^0 + s[1]*p^1 + ... + s[k-1]*p^(k-1)) % m,
    // where s[j] refers to the j-th character of the *substring*.
    // So, for substring s[start_idx ... start_idx+k-1]:
    // hash = (s[start_idx]*p^0 + s[start_idx+1]*p^1 + ... + s[start_idx+k-1]*p^(k-1)) % m
    for (int j = 0; j < k; ++j) {
        // s[n - k + j] is the (j)-th character of the current window (s[n-k ... n-1])
        current_hash = (current_hash + (long long)(s[n - k + j] - 'a') * power_of_p_for_initial_window) % m;
        power_of_p_for_initial_window = (power_of_p_for_initial_window * p) % m;
    }

    // If this rightmost substring matches the hashValue, it's our answer
    if (current_hash == hashValue) {
        return s + (n - k); // Return pointer to the start of the substring
    }

    // Slide the window to the left
    // We iterate 'i' from n-k-1 down to 0.
    // 'current_hash' initially holds the hash for s[i+1 ... i+k] (which is s[n-k ... n-1] in the first iteration).
    // We want to calculate the hash for s[i ... i+k-1].
    for (int i = n - k - 1; i >= 0; --i) {
        // Step 1: Remove the contribution of the character that leaves the window from the right.
        // This is s[i+k], which was multiplied by p^(k-1) in the previous window's hash.
        long long char_to_remove_val = (s[i + k] - 'a');
        long long term_to_remove = (char_to_remove_val * p_pow_k_minus_1) % m;
        current_hash = (current_hash - term_to_remove + m) % m; // Add m to ensure positive result before modulo

        // Step 2: Multiply the remaining hash by p.
        // This shifts the powers of p for all characters remaining in the window (s[i+1]...s[i+k-1]).
        // E.g., s[i+1]*p^0 becomes s[i+1]*p^1, s[i+2]*p^1 becomes s[i+2]*p^2, etc.
        current_hash = (current_hash * p) % m;

        // Step 3: Add the contribution of the new character entering the window from the left.
        // This is s[i], which is multiplied by p^0 in the new window's hash.
        long long char_to_add_val = (s[i] - 'a');
        current_hash = (current_hash + char_to_add_val) % m;

        // Check if this new hash matches the target hashValue
        if (current_hash == hashValue) {
            return s + i; // Return pointer to the start of this substring
        }
    }

    // The problem guarantees that a solution always exists, so this line should not be reached.
    return NULL;
}