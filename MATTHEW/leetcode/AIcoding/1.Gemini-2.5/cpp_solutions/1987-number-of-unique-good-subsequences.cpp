#include <string>
#include <vector>

class Solution {
public:
    int numberOfUniqueGoodSubsequences(std::string binary) {
        long long dp00 = 0; // Unique subsequences starting with '0' and ending with '0'
        long long dp11 = 0; // Unique subsequences starting with '1' and ending with '1'
        long long dp01 = 0; // Unique subsequences starting with '0' and ending with '1'
        long long dp10 = 0; // Unique subsequences starting with '1' and ending with '0'

        long long MOD = 1e9 + 7;

        bool has_zero = false; // To check if '0' exists in the string

        for (char c : binary) {
            if (c == '0') {
                // When we encounter '0':
                // 1. New '0...0' subsequences:
                //    - The single character "0" itself (if it's the first '0' being considered).
                //    - Extend existing '0...0' subsequences with '0'.
                //    - Extend existing '0...1' subsequences with '0' (they become '0...10', which is '0...0').
                //    So, new_dp00 = (1 + dp00 + dp01)
                long long new_dp00 = (1 + dp00 + dp01) % MOD;

                // 2. New '1...0' subsequences:
                //    - Extend existing '1...0' subsequences with '0'.
                //    - Extend existing '1...1' subsequences with '0' (they become '1...10', which is '1...0').
                //    So, new_dp10 = (dp10 + dp11)
                long long new_dp10 = (dp10 + dp11) % MOD;

                dp00 = new_dp00;
                dp10 = new_dp10;
                has_zero = true; // Mark that '0' has been seen
            } else { // c == '1'
                // When we encounter '1':
                // 1. New '0...1' subsequences:
                //    - Extend existing '0...1' subsequences with '1'.
                //    - Extend existing '0...0' subsequences with '1' (they become '0...01', which is '0...1').
                //    So, new_dp01 = (dp01 + dp00)
                long long new_dp01 = (dp01 + dp00) % MOD;

                // 2. New '1...1' subsequences:
                //    - The single character "1" itself.
                //    - Extend existing '1...1' subsequences with '1'.
                //    - Extend existing '1...0' subsequences with '1' (they become '1...01', which is '1...1').
                //    So, new_dp11 = (1 + dp11 + dp10)
                long long new_dp11 = (1 + dp11 + dp10) % MOD;

                dp01 = new_dp01;
                dp11 = new_dp11;
            }
        }

        // The total number of unique good subsequences is the sum of '0...0' and '1...1' subsequences.
        // If the string contains '0', then "0" itself is a good subsequence.
        // The DP states `dp00` and `dp11` already count single characters "0" and "1" respectively
        // when they are first encountered via the `+1` term.
        // However, if the string only contains '1's, `dp00` will be 0.
        // If the string only contains '0's, `dp11` will be 0.
        // The problem statement implies "0" and "1" are good subsequences.
        // Our DP correctly counts "0" in `dp00` and "1" in `dp11`.

        long long total_good_subsequences = (dp00 + dp11) % MOD;

        // Special case: if the string contains at least one '0', then "0" is a good subsequence.
        // The current DP correctly handles this.
        // For example, if binary="0", dp00=1, dp11=0. Total = 1. ("0")
        // If binary="1", dp00=0, dp11=1. Total = 1. ("1")
        // If binary="00", dp00=2 ("0", "00"), dp11=0. Total = 2.
        // The `+1` in the DP state updates accounts for the single character itself.
        // The logic seems to be correct.

        return total_good_subsequences;
    }
};