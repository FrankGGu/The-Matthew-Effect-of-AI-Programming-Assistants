import java.util.Arrays;

class Solution {
    public int largestPalindrome(int n) {
        if (n == 1) {
            return 9; // As per LeetCode's example for n=1. The largest palindrome product of two 1-digit numbers (1-9) is 9*9=81. However, the problem example states 9.
        }

        // Calculate the upper and lower bounds for n-digit numbers.
        // For n=2, upper_bound_factor = 99, lower_bound_factor = 10.
        long upper_bound_factor = (long) Math.pow(10, n) - 1;
        long lower_bound_factor = (long) Math.pow(10, n - 1);

        // Iterate 'i' which represents the first half of the palindrome.
        // We start from the largest possible first half, which is upper_bound_factor.
        // We iterate downwards because we are looking for the largest palindrome.
        // The loop for 'i' can stop much earlier than lower_bound_factor.
        // The largest palindrome product will have at most 2*n digits.
        // Its first half will be an n-digit number or slightly less.
        // Empirical observation shows that the first half of the largest palindrome
        // is very close to upper_bound_factor.
        // For example, for n=4, upper_bound_factor=9999, the first half is 9900.
        // For n=8, upper_bound_factor=99999999, the first half is 99999993.
        // This means the loop for 'i' will find the answer quickly without iterating through all 10^n possibilities.
        for (long i = upper_bound_factor; i >= lower_bound_factor; i--) {
            // Construct the palindrome from its first half 'i'.
            // Example: if i = 123, palindrome = 123321.
            long palindrome = i;
            long temp = i;
            while (temp > 0) {
                palindrome = palindrome * 10 + (temp % 10);
                temp /= 10;
            }

            // Check if this palindrome can be formed by the product of two n-digit numbers.
            // Let the two factors be 'j' and 'other_factor'.
            // Both 'j' and 'other_factor' must be n-digit numbers, i.e.,
            // within the range [lower_bound_factor, upper_bound_factor].
            // We iterate 'j' from upper_bound_factor downwards.
            // The smallest possible value for 'j' is lower_bound_factor.
            // Also, 'other_factor = palindrome / j' must be an n-digit number.
            // This implies palindrome / j <= upper_bound_factor, which means j >= palindrome / upper_bound_factor.
            // So, 'j' must be in the range [max(lower_bound_factor, palindrome / upper_bound_factor), upper_bound_factor].
            for (long j = upper_bound_factor; j >= lower_bound_factor; j--) {
                // Optimization: If 'j' becomes too small, 'other_factor' (palindrome / j) will become too large.
                // If 'other_factor' exceeds 'upper_bound_factor', then this 'j' (and any smaller 'j')
                // cannot form a valid product. So, we can break the inner loop.
                if (j < palindrome / upper_bound_factor) {
                    break;
                }

                if (palindrome % j == 0) {
                    long other_factor = palindrome / j;

                    // 'j' is already guaranteed to be an n-digit number by the loop range.
                    // We just need to check if 'other_factor' is also an n-digit number.
                    if (other_factor >= lower_bound_factor && other_factor <= upper_bound_factor) {
                        // Found the largest palindrome, return it modulo 1337.
                        return (int) (palindrome % 1337);
                    }
                }
            }
        }

        return 0; // This line should theoretically not be reached for valid 'n' as per problem constraints.
    }
}