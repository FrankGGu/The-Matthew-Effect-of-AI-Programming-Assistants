#include <stdlib.h> // For qsort
#include <stdio.h>  // For NULL, though not strictly needed if no printing

long long reverse_num(long long n) {
    long long rev = 0;
    while (n > 0) {
        rev = rev * 10 + n % 10;
        n /= 10;
    }
    return rev;
}

int count_digits(long long n) {
    if (n == 0) return 1;
    int count = 0;
    long long temp = n;
    while (temp > 0) {
        temp /= 10;
        count++;
    }
    return count;
}

int compare_long_long_desc(const void *a, const void *b) {
    long long val_a = *(long long*)a;
    long long val_b = *(long long*)b;
    if (val_a > val_b) return -1;
    if (val_a < val_b) return 1;
    return 0;
}

long long largestPalindromeDivisibleByK(int k) {
    // A reasonable upper bound for the first half of the palindrome.
    // max_half_val = 999999 generates palindromes up to 12 digits (999999999999).
    // This range is typically sufficient for problems without explicit 'N' and fits within memory/time limits.
    long long max_half_val = 999999; 

    // Allocate an array to store palindromes.
    // Each 'i' generates two palindromes (even and odd length).
    // Max size: 2 * max_half_val
    long long* palindromes = (long long*)malloc(sizeof(long long) * (max_half_val * 2 + 1));
    if (palindromes == NULL) {
        // Handle allocation failure, though unlikely in LeetCode environment
        return -1; 
    }
    int count = 0;

    for (long long i = 1; i <= max_half_val; ++i) {
        long long reversed_i = reverse_num(i);
        int num_digits_i = count_digits(i);

        long long power_of_10 = 1;
        for (int d = 0; d < num_digits_i; ++d) {
            power_of_10 *= 10;
        }

        // Construct even-length palindrome
        // e.g., i = 123, reversed_i = 321, num_digits_i = 3, power_of_10 = 1000
        // p_even = 123 * 1000 + 321 = 123321
        long long p_even = i * power_of_10 + reversed_i;
        palindromes[count++] = p_even;

        // Construct odd-length palindrome
        // e.g., i = 123, reversed_i = 321, num_digits_i = 3, power_of_10 = 1000
        // p_odd = 123 * (1000 / 10) + (321 / 10) = 123 * 100 + 32 = 12332
        long long p_odd = i * (power_of_10 / 10) + (reversed_i / 10);
        palindromes[count++] = p_odd;
    }

    // Sort the palindromes in descending order
    qsort(palindromes, count, sizeof(long long), compare_long_long_desc);

    // Find the first palindrome divisible by k
    for (int j = 0; j < count; ++j) {
        if (palindromes[j] % k == 0) {
            long long result = palindromes[j];
            free(palindromes);
            return result;
        }
    }

    // Should not be reached if k >= 1 and max_half_val is sufficiently large (e.g., 1 is a palindrome).
    // Returning -1 or 0 to indicate no solution found within the search space.
    free(palindromes);
    return -1; 
}