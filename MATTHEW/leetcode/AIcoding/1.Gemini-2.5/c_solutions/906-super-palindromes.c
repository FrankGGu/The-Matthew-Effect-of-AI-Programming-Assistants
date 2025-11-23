#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

bool isPalindrome(unsigned long long n) {
    unsigned long long original_n = n;
    unsigned long long reversed_n = 0;
    while (n > 0) {
        reversed_n = reversed_n * 10 + (n % 10);
        n /= 10;
    }
    return original_n == reversed_n;
}

int superpalindromesInRange(char * L, char * R){
    unsigned long long L_val = strtoull(L, NULL, 10);
    unsigned long long R_val = strtoull(R, NULL, 10);
    int count = 0;

    // Iterate 'i' to construct palindromes 'P'.
    // The maximum value for P is sqrt(R_val). Since R_val < 10^18, P < 10^9.
    // To generate a 9-digit palindrome (e.g., 999,999,999), the first half 'i' is 99999.
    // So 'i' needs to go up to 99999. Loop limit `i < 100000` is correct.
    for (unsigned long long i = 1; i < 100000; ++i) {
        char temp_s[7]; // Max i is 99999 (5 digits), so 6 chars + null terminator.
        sprintf(temp_s, "%llu", i);
        int n_digits = strlen(temp_s);

        // --- Generate odd length palindrome P_val_odd ---
        char p_buf_odd[12]; // Max 9 digits for P (e.g., 999999999), + null terminator.
        strcpy(p_buf_odd, temp_s);
        for (int k = n_digits - 2; k >= 0; --k) {
            p_buf_odd[n_digits + (n_digits - 2 - k)] = temp_s[k];
        }
        p_buf_odd[n_digits + (n_digits - 1)] = '\0';

        unsigned long long p_val_odd = strtoull(p_buf_odd, NULL, 10);

        // Optimization: If p_val_odd is already too large, its square will exceed R_val.
        // P must be < 10^9. If P >= 10^9, P*P >= 10^18. Since R < 10^18, P*P will be out of range.
        // This check also helps prevent potential overflow if p_val_odd were to exceed sqrt(ULL_MAX).
        // However, ULL_MAX is ~1.8e19, so P up to 4e9 would fit, which is beyond our P limit of 1e9.
        // So the check `p_val_odd * p_val_odd > R_val` is sufficient.
        unsigned long long square_odd = p_val_odd * p_val_odd;
        if (square_odd > R_val) {
            // If the current odd palindrome's square is already too large,
            // subsequent odd palindromes (and their squares) will also be too large.
            // However, even palindromes might still be in range for this 'i'.
            // So we cannot break the loop entirely, but we can stop processing odd palindromes for larger 'i'.
            // For 'i' = 99999, p_val_odd = 999999999. Its square is ~10^18.
            // For 'i' = 100000, p_val_odd = 10000000001 (11 digits). This is already > 10^9.
            // So if p_val_odd itself is >= 10^9 (or > 999999999), we can stop.
            // The loop condition `i < 100000` already ensures `p_val_odd` is at most 9 digits.
            // So `p_val_odd` is at most `999,999,999`. Its square is at most `9.99...e17`.
            // So `square_odd > R_val` is the only relevant check here.
            // If `square_odd` is too large, it means `p_val_odd` is too large.
            // Since `i` is increasing, `p_val_odd` will also increase.
            // So we can break from the loop for `i` if `square_odd > R_val` for odd palindromes.
            // This is because odd palindromes grow faster than even palindromes for the same `i` (usually longer).
            // Example: i=12, P_odd=121, P_even=1221.
            // So if `square_odd` exceeds `R_val`, `square_even` for the same `i` (if it was larger than `p_val_odd`) would also exceed.
            // If `p_val_odd` is smaller than `p_val_even`, `square_odd` might be within range while `square_even` is not.
            // However, `p_val_odd` is usually larger or similar in magnitude to `p_val_even` for the same `i`.
            // Example: i=1, P_odd=1, P_even=11.
            // Example: i=12, P_odd=121, P_even=1221.
            // Example: i=123, P_odd=12321, P_even=123321.
            // So `p_val_even` is typically larger than `p_val_odd` for the same `i`.
            // This means if `square_odd` exceeds `R_val`, `square_even` will also likely exceed `R_val`.
            // It's safe to `break` here.
            break; 
        }

        if (square_odd >= L_val && isPalindrome(square_odd)) {
            count++;
        }

        // --- Generate even length palindrome P_val_even ---
        char p_buf_even[12]; // Max 10 digits for P (e.g., 9999999999), + null terminator.
        strcpy(p_buf_even, temp_s);
        for (int k = n_digits - 1; k >= 0; --k) {
            p_buf_even[n_digits + (n_digits - 1 - k)] = temp_s[k];
        }
        p_buf_even[n_digits + n_digits] = '\0';

        unsigned long long p_val_even = strtoull(p_buf_even, NULL, 10);

        // If P_val_even is 10^9 or more, its square is 10^18 or more.
        // Since R_val < 10^18, such a square will always be out of range.
        // This check is important because p_val_even can easily exceed 10^9 for i < 100000.
        // For i = 10000, p_val_even = 1000000001 (10 digits).
        if (p_val_even >= 1000000000ULL) {
            // If `p_val_even` is already too large, all subsequent `p_val_even` for larger `i` will also be too large.
            // However, `p_val_odd` might still be valid for larger `i`. So we cannot `break` the main loop here.
            continue; // Skip to next 'i' for even palindrome part.
        }

        unsigned long long square_even = p_val_even * p_val_even;
        if (square_even > R_val) {
            // If the current even palindrome's square is already too large,
            // all subsequent even palindromes (and their squares) will also be too large.
            // For the same reason as for `p_val_odd`, if `square_even` exceeds `R_val`,
            // and `p_val_even` is typically larger than `p_val_odd`, then `square_odd` would have already exceeded.
            // So it's safe to `break` here as well.
            break;
        }

        if (square_even >= L_val && isPalindrome(square_even)) {
            count++;
        }
    }
    return count;
}