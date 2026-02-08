#include <stdbool.h>
#include <math.h>

bool isPrime(int num) {
    if (num < 2) {
        return false;
    }
    if (num == 2 || num == 3) {
        return true;
    }
    if (num % 2 == 0 || num % 3 == 0) {
        return false;
    }
    for (int i = 5; (long long)i * i <= num; i += 6) {
        if (num % i == 0 || num % (i + 2) == 0) {
            return false;
        }
    }
    return true;
}

int primePalindrome(int n) {
    // Handle small base cases
    if (n <= 2) return 2;
    if (n <= 3) return 3;
    if (n <= 5) return 5;
    if (n <= 7) return 7;
    if (n <= 11) return 11; // 11 is the only even-digit prime palindrome

    // Optimization: All even-digit palindromes (except 11) are divisible by 11.
    // Thus, we only need to check odd-digit palindromes.
    // We generate odd-length palindromes and check if they are prime and >= n.

    // Iterate 'i' to construct the first half (including middle digit) of odd-length palindromes.
    // Example: i = 123 -> palindrome = 12321
    // The maximum possible answer for n <= 10^8 is 100030001.
    // The largest prime palindrome below 2 * 10^8 is 199999991.
    // This palindrome (199999991) is generated from i = 19999.
    // So, 'i' needs to go up to 19999 to cover all relevant 9-digit palindromes.
    for (int i = 1; i < 20000; ++i) { // Iterates 'i' from 1 to 19999
        int palindrome = i;
        int temp = i / 10; // For odd-length palindromes, exclude the last digit of 'i' when reversing
        while (temp > 0) {
            palindrome = palindrome * 10 + (temp % 10);
            temp /= 10;
        }

        // Check if the generated palindrome meets the criteria
        if (palindrome >= n && isPrime(palindrome)) {
            return palindrome;
        }
    }

    return -1; // Should not be reached based on problem constraints
}