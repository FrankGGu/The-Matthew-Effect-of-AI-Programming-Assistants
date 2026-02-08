#include <string>
#include <vector>
#include <algorithm>
#include <cstring> // For memset
#include <functional> // For std::function

class Solution {
public:
    long long powerful_dp[20][2];
    std::string num_str_ref;
    std::string s_str_ref;
    int limit_ref;
    int N_len_ref;
    int M_ref;

    // Helper function to calculate base^exp for long long
    long long power(int base, int exp) {
        long long res = 1;
        for (int i = 0; i < exp; ++i) {
            res *= base;
        }
        return res;
    }

    // Digit DP function to count powerful integers up to num_str_ref
    long long dfs(int idx, bool tight) {
        // Base case: If we have successfully filled all digits, we found one valid number.
        if (idx == N_len_ref) {
            return 1;
        }
        // Memoization: If result for this state is already computed, return it.
        if (powerful_dp[idx][tight] != -1) {
            return powerful_dp[idx][tight];
        }

        long long res = 0;
        // Determine the upper bound for the current digit.
        // If tight is true, we are restricted by the digit in num_str_ref.
        // Otherwise, we can use any digit up to 9.
        int upper_bound = tight ? (num_str_ref[idx] - '0') : 9;

        if (idx < M_ref) { 
            // We are in the prefix part, the current digit MUST match s_str_ref[idx].
            int d = s_str_ref[idx] - '0';
            // Check if the required digit 'd' can be placed without exceeding upper_bound.
            if (d <= upper_bound) {
                // Recursively call for the next digit. Update tight if 'd' is the upper_bound.
                res = dfs(idx + 1, tight && (d == upper_bound));
            }
        } else { 
            // We are in the suffix part, digits must be in the range [1, limit_ref].
            for (int d = 1; d <= limit_ref; ++d) {
                // Check if the current digit 'd' can be placed without exceeding upper_bound.
                if (d <= upper_bound) {
                    // Recursively call for the next digit. Update tight if 'd' is the upper_bound.
                    res += dfs(idx + 1, tight && (d == upper_bound));
                } else {
                    // If 'd' exceeds upper_bound, any larger digit will also exceed it, so break.
                    break;
                }
            }
        }
        // Store and return the computed result.
        return powerful_dp[idx][tight] = res;
    }

    // Main function to count powerful integers up to a given N_val
    long long countPowerful(long long N_val, std::string S_str, int L_limit) {
        num_str_ref = std::to_string(N_val);
        s_str_ref = S_str;
        limit_ref = L_limit;
        N_len_ref = num_str_ref.length();
        M_ref = s_str_ref.length();

        long long ans = 0;

        // Part 1: Count powerful numbers with length `len` such that `M_ref <= len < N_len_ref`.
        // These numbers are always strictly less than `N_val`.
        // For each such length, the first M_ref digits are fixed by s_str_ref.
        // The remaining `len - M_ref` digits can be any from 1 to limit_ref.
        for (int len = M_ref; len < N_len_ref; ++len) {
            ans += power(limit_ref, len - M_ref);
        }

        // Part 2: Count powerful numbers with length `N_len_ref` that are `<= N_val`.
        // This part uses the digit DP `dfs` function.
        // Only proceed if the prefix `s_str_ref` can fit into `N_val`'s length.
        if (M_ref <= N_len_ref) {
            // Initialize memoization table with -1 before each DP call.
            memset(powerful_dp, -1, sizeof(powerful_dp));
            ans += dfs(0, true); // Start DP from index 0 with tight constraint.
        }

        return ans;
    }

    // The main solution function for the LeetCode problem.
    long long numberOfPowerfulInt(long long start, long long finish, int limit, std::string s) {
        // Use the principle of inclusion-exclusion: count(finish) - count(start - 1).
        return countPowerful(finish, s, limit) - countPowerful(start - 1, s, limit);
    }
};