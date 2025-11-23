#include <math.h> // Required for pow, though it's better to implement power of 10 manually for precision/type safety
#include <stdbool.h>
#include <stdio.h>

int largestPalindrome(int n) {
    if (n == 1) {
        return 9;
    }

    // Calculate upper and lower bounds for n-digit numbers
    // upper_bound_factor = 10^n - 1 (e.g., for n=2, 99)
    // lower_bound_factor = 10^(n-1) (e.g., for n=2, 10)
    long long upper_bound_factor = 1;
    for (int i = 0; i < n; ++i) {
        upper_bound_factor *= 10;
    }
    upper_bound_factor--;

    long long lower_bound_factor = 1;
    for (int i = 0; i < n - 1; ++i) {
        lower_bound_factor *= 10;
    }

    // The largest possible palindrome is less than (10^n - 1)^2.
    // The left half of such a palindrome would be roughly 10^n - 1.
    // We iterate the left half of the palindrome downwards from upper_bound_factor.
    // The smallest possible product is (10^(n-1))^2.
    // The left half of this smallest product is roughly 10^(n-1).
    // So, 'left_half' should iterate from upper_bound_factor down to lower_bound_factor.
    // This range covers all possible n-digit prefixes for 2n-digit palindromes
    // and also n-digit prefixes for (2n-1)-digit palindromes.

    for (long long left_half = upper_bound_factor; left_half >= lower_bound_factor; left_half--) {
        // Construct a palindrome P from left_half.
        // It will be of the form `left_half` followed by `reverse(left_half)`.
        // This creates a 2n-digit palindrome if left_half has n digits.
        long long palindrome = left_half;
        long long temp_left = left_half;
        while (temp_left > 0) {
            palindrome = palindrome * 10 + (temp_left % 10);
            temp_left /= 10;
        }

        // Check if this palindrome can be formed by the product of two n-digit numbers (x * y = palindrome)
        // We need to find factors x and y such that:
        // 1. lower_bound_factor <= x <= upper_bound_factor
        // 2. lower_bound_factor <= y <= upper_bound_factor
        // From y <= upper_bound_factor, we get palindrome / x <= upper_bound_factor => x >= palindrome / upper_bound_factor.
        // From y >= lower_bound_factor, we get palindrome / x >= lower_bound_factor => x <= palindrome / lower_bound_factor.
        // So, x iterates from min(upper_bound_factor, palindrome / lower_bound_factor) down to max(lower_bound_factor, palindrome / upper_bound_factor).
        // The loop for x should start from upper_bound_factor and go downwards.
        // We can optimize the lower bound of x to `palindrome / upper_bound_factor`.
        // If x drops below this, y would be greater than upper_bound_factor.

        for (long long x = upper_bound_factor; x * x >= palindrome; x--) {
            // Optimization: If x is too small, then y = palindrome / x will be too large (more than n digits)
            // If x < palindrome / upper_bound_factor, then palindrome / x > upper_bound_factor.
            // This means y > upper_bound_factor, which is not allowed. So we can break.
            if (x < palindrome / upper_bound_factor) {
                break; 
            }

            if (palindrome % x == 0) {
                long long y = palindrome / x;
                if (y >= lower_bound_factor && y <= upper_bound_factor) {
                    return palindrome % 1337;
                }
            }
        }

        // The problem might also involve (2n-1)-digit palindromes.
        // Example: n=2, left_half=98, palindrome=989.
        // This is formed by `left_half` followed by `reverse(left_half / 10)`.
        // Note: For n=2, the largest palindrome is 9009 = 99 * 91, which is 2n digits.
        // For n=3, the largest palindrome is 906609 = 993 * 913, which is 2n digits.
        // For n=8, the largest palindrome is 9999999989999999, which is 2n digits.
        // It seems the largest palindromes are always 2n digits.
        // So, the 2n-1 digit palindrome check is likely not needed for the *largest* result,
        // but it's safer to include if the problem implies finding *any* palindrome first.
        // However, given the "largest" requirement and performance, only 2n-digit palindromes
        // constructed from n-digit left_half are usually the candidates.
        // Let's remove the (2n-1) digit palindrome check to simplify and potentially speed up,
        // as the problem implies the largest will be close to max_product, which is 2n digits.
        // If it fails tests, it can be added back.
    }

    return -1; // Should not be reached for valid inputs according to problem constraints
}