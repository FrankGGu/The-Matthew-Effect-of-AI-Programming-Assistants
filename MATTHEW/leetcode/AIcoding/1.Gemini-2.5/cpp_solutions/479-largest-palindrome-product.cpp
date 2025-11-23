#include <string>
#include <algorithm>
#include <cmath> // For std::pow

class Solution {
public:
    int largestPalindrome(int n) {
        // Special case for n=1.
        // The general logic constructs 2n-digit palindromes.
        // For n=1, the largest palindrome product is 9 (e.g., 1*9 or 3*3).
        // A 2-digit palindrome like 11 cannot be formed by two 1-digit numbers (11 = 1*11, 11 is not 1-digit).
        if (n == 1) {
            return 9;
        }

        // Calculate the upper and lower bounds for n-digit numbers.
        // For example, if n=2, upper_bound = 99, lower_bound = 10.
        // std::pow returns a double, so cast to long long.
        long long upper_bound = std::pow(10, n) - 1;
        long long lower_bound = std::pow(10, n - 1);

        // Iterate on the first half of the potential palindrome, starting from the largest possible n-digit number.
        // This approach generates 2n-digit palindromes (e.g., if i=99, palindrome=9999).
        // We start with the largest possible 'i' because we are looking for the largest palindrome.
        for (long long i = upper_bound; i >= lower_bound; --i) {
            std::string s_i = std::to_string(i);
            std::string s_rev_i = s_i;
            std::reverse(s_rev_i.begin(), s_rev_i.end());
            long long palindrome = std::stoll(s_i + s_rev_i);

            // Now, try to factorize the generated palindrome into two n-digit numbers.
            // Let the two factors be 'j' and 'k'. Both 'j' and 'k' must be n-digit numbers.
            // So, lower_bound <= j <= upper_bound and lower_bound <= k <= upper_bound.
            // We iterate 'j' downwards from 'upper_bound'.
            //
            // Optimization 1: We only need to check 'j' down to sqrt(palindrome).
            // If j * j < palindrome, it means j < sqrt(palindrome).
            // In this case, k = palindrome / j would be > sqrt(palindrome).
            // Since we iterate j downwards, if k is a valid n-digit factor, we would have already found it
            // when j was equal to k (the larger factor). So we can break early.
            //
            // Optimization 2: 'j' must be an n-digit number, so 'j' must be >= lower_bound.
            for (long long j = upper_bound; j >= lower_bound; --j) {
                // Optimization 1: If j is too small, its pair k will be too large (k > j).
                // If k is a valid factor, it would have been found when 'j' was 'k'.
                if (j * j < palindrome) {
                    break;
                }

                if (palindrome % j == 0) {
                    long long k = palindrome / j;
                    // Check if k is also an n-digit number.
                    // Since j >= lower_bound and j * j >= palindrome, it implies k <= j <= upper_bound.
                    // So, k <= upper_bound is implicitly true. We only need to check k >= lower_bound.
                    if (k >= lower_bound) {
                        return palindrome % 1337;
                    }
                }
            }
        }

        // This line should theoretically not be reached given the problem constraints (a solution always exists).
        // It's good practice to have a return statement.
        return 0; 
    }
};