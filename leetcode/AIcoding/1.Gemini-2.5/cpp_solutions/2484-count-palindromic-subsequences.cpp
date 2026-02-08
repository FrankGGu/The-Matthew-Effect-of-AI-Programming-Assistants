#include <string>
#include <vector>

class Solution {
public:
    int countPalindromicSubsequences(std::string s) {
        int n = s.length();
        long long MOD = 1e9 + 7;

        // prefix_digit_counts[i][d] stores count of digit 'd' in s[0...i-1]
        std::vector<std::vector<int>> prefix_digit_counts(n + 1, std::vector<int>(10, 0));
        // prefix_pair_counts[i][d1][d2] stores count of subsequences "d1d2" in s[0...i-1]
        std::vector<std::vector<std::vector<long long>>> prefix_pair_counts(n + 1, std::vector<std::vector<long long>>(10, std::vector<long long>(10, 0)));

        for (int i = 0; i < n; ++i) {
            int current_digit = s[i] - '0';
            // Copy counts from previous state (s[0...i-1]) to current state (s[0...i])
            for (int d1 = 0; d1 < 10; ++d1) {
                for (int d2 = 0; d2 < 10; ++d2) {
                    prefix_pair_counts[i + 1][d1][d2] = prefix_pair_counts[i][d1][d2];
                }
                prefix_digit_counts[i + 1][d1] = prefix_digit_counts[i][d1];
            }

            // Update pair counts ending with current_digit (s[i])
            // For each digit d1, add (count of d1 in s[0...i-1]) * 1 (for s[i] as current_digit)
            for (int d1 = 0; d1 < 10; ++d1) {
                prefix_pair_counts[i + 1][d1][current_digit] = (prefix_pair_counts[i + 1][d1][current_digit] + prefix_digit_counts[i][d1]) % MOD;
            }
            // Update single digit count for current_digit
            prefix_digit_counts[i + 1][current_digit]++;
        }

        // suffix_digit_counts[i][d] stores count of digit 'd' in s[i...N-1]
        std::vector<std::vector<int>> suffix_digit_counts(n + 1, std::vector<int>(10, 0));
        // suffix_pair_counts[i][d1][d2] stores count of subsequences "d1d2" in s[i...N-1]
        std::vector<std::vector<std::vector<long long>>> suffix_pair_counts(n + 1, std::vector<std::vector<long long>>(10, std::vector<long long>(10, 0)));

        for (int i = n - 1; i >= 0; --i) {
            int current_digit = s[i] - '0';
            // Copy counts from previous state (s[i+1...N-1]) to current state (s[i...N-1])
            for (int d1 = 0; d1 < 10; ++d1) {
                for (int d2 = 0; d2 < 10; ++d2) {
                    suffix_pair_counts[i][d1][d2] = suffix_pair_counts[i + 1][d1][d2];
                }
                suffix_digit_counts[i][d1] = suffix_digit_counts[i + 1][d1];
            }

            // Update pair counts starting with current_digit (s[i])
            // For each digit d2, add 1 (for s[i] as current_digit) * (count of d2 in s[i+1...N-1])
            for (int d2 = 0; d2 < 10; ++d2) {
                suffix_pair_counts[i][current_digit][d2] = (suffix_pair_counts[i][current_digit][d2] + suffix_digit_counts[i + 1][d2]) % MOD;
            }
            // Update single digit count for current_digit
            suffix_digit_counts[i][current_digit]++;
        }

        long long total_palindromes = 0;
        // Iterate through each character s[k] as the middle character of the 'abcba' palindrome
        // The palindrome is formed as (d1 d2) + s[k] + (d2 d1)
        for (int k = 0; k < n; ++k) {
            for (int d1 = 0; d1 < 10; ++d1) {
                for (int d2 = 0; d2 < 10; ++d2) {
                    // Count of "d1d2" subsequences in s[0...k-1]
                    long long left_ab_count = prefix_pair_counts[k][d1][d2]; 
                    // Count of "d2d1" subsequences in s[k+1...N-1]
                    long long right_ba_count = suffix_pair_counts[k + 1][d2][d1]; 
                    total_palindromes = (total_palindromes + left_ab_count * right_ba_count) % MOD;
                }
            }
        }

        return static_cast<int>(total_palindromes);
    }
};