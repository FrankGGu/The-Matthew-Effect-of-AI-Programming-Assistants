class Solution {
    public int largestPalindrome(int n) {
        if (n == 1) {
            return 9;
        }

        long upper = (long) Math.pow(10, n) - 1; // Largest n-digit number (e.g., 99 for n=2)
        long lower = (long) Math.pow(10, n - 1); // Smallest n-digit number (e.g., 10 for n=2)

        // Iterate through the first half of potential palindromes.
        // The largest possible palindrome will have 2*n digits.
        // The first half will be an n-digit number.
        // We iterate 'i' from the largest n-digit number downwards.
        for (long i = upper; i >= lower; i--) {
            long firstHalf = i;
            long palindrome = firstHalf;
            long temp = firstHalf;

            // Construct the palindrome (e.g., if firstHalf=91, palindrome=9119)
            while (temp > 0) {
                palindrome = palindrome * 10 + (temp % 10);
                temp /= 10;
            }

            // Check if this 'palindrome' can be formed by the product of two n-digit numbers.
            // One factor 'x' will range from 'upper' downwards.
            // The other factor 'y = palindrome / x' must also be an n-digit number.
            // So, 'y' must be >= 'lower'.
            // This implies 'palindrome / x >= lower', or 'x <= palindrome / lower'.
            // Also, 'y' must be <= 'upper'.
            // This implies 'palindrome / x <= upper', or 'x >= palindrome / upper'.
            // So 'x' iterates from 'upper' down to 'max(lower, palindrome / upper)'.

            for (long x = upper; x >= lower; x--) {
                // Optimization: If x is too small such that y = palindrome / x would be greater than upper,
                // then any smaller x will also result in y > upper. So we can break.
                // This condition is equivalent to: if (x < palindrome / upper) break;
                if (x * upper < palindrome) {
                    break;
                }

                if (palindrome % x == 0) {
                    long y = palindrome / x;
                    // Check if 'y' is also an n-digit number
                    if (y >= lower && y <= upper) {
                        return (int) (palindrome % 1337);
                    }
                }
            }
        }
        return -1; // Should not be reached for valid inputs based on problem constraints
    }
}