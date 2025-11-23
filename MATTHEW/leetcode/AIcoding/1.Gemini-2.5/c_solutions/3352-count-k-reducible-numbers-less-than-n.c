#include <string.h>
#include <stdio.h>
#include <stdbool.h>

char S[25]; // Max length for long long (10^18) is 19 digits, plus null terminator, so 25 is safe.
int K_val;
long long memo[25][2][100][100][2]; // Dimensions: idx, tight, current_num_mod_k, current_sum_digits_mod_k, is_started

void init_memo() {
    for (int i = 0; i < 25; ++i) {
        for (int j = 0; j < 2; ++j) {
            for (int l = 0; l < 100; ++l) {
                for (int m = 0; m < 100; ++m) {
                    for (int n = 0; n < 2; ++n) {
                        memo[i][j][l][m][n] = -1;
                    }
                }
            }
        }
    }
}

long long dp(int idx, bool tight, int current_num_mod_k, int current_sum_digits_mod_k, bool is_started) {
    // Base case: All digits have been processed
    if (idx == strlen(S)) {
        // A number is valid if it's a non-zero number (is_started is true)
        // AND both the number itself and its sum of digits are divisible by K_val.
        if (is_started && current_num_mod_k == 0 && current_sum_digits_mod_k == 0) {
            return 1; // Found one k-reducible number
        }
        return 0; // Not a valid k-reducible number (e.g., 0, or conditions not met)
    }

    // Check if this state has already been computed
    if (memo[idx][tight][current_num_mod_k][current_sum_digits_mod_k][is_started] != -1) {
        return memo[idx][tight][current_num_mod_k][current_sum_digits_mod_k][is_started];
    }

    long long ans = 0;
    // Determine the upper bound for the current digit
    // If tight is true, the current digit cannot exceed S[idx].
    // Otherwise, it can be any digit from 0 to 9.
    int upper_bound = tight ? (S[idx] - '0') : 9;

    // Iterate through possible digits for the current position
    for (int digit = 0; digit <= upper_bound; ++digit) {
        if (!is_started && digit == 0) {
            // If we are still placing leading zeros, the number and sum modulo K_val remain 0.
            // is_started remains false.
            ans += dp(idx + 1, tight && (digit == upper_bound), 0, 0, false);
        } else {
            // We have placed a non-zero digit, or we are past the leading zero phase.
            // Update current_num_mod_k and current_sum_digits_mod_k.
            // is_started becomes true.
            int next_num_mod_k = (current_num_mod_k * 10 + digit) % K_val;
            int next_sum_digits_mod_k = (current_sum_digits_mod_k + digit) % K_val;
            ans += dp(idx + 1, tight && (digit == upper_bound), next_num_mod_k, next_sum_digits_mod_k, true);
        }
    }

    // Store the computed result in the memoization table and return it
    return memo[idx][tight][current_num_mod_k][current_sum_digits_mod_k][is_started] = ans;
}

void num_to_string(long long n, char* str) {
    sprintf(str, "%lld", n);
}

long long countKReducibleNumbers(long long n, int k) {
    K_val = k; // Set the global K_val

    // The problem asks for numbers x such that 1 <= x < N.
    // Our DP function counts numbers x such that 0 <= x <= upper_limit.
    // Since our DP naturally excludes 0 (due to the 'is_started' logic),
    // we need to set the upper_limit to N - 1.
    if (n <= 1) {
        return 0; // No positive numbers less than N if N is 0 or 1.
    }
    long long upper_limit = n - 1;

    num_to_string(upper_limit, S); // Convert (N-1) to string for digit DP
    init_memo(); // Initialize memoization table for a new calculation

    // Start the DP process:
    // - idx: 0 (start from the most significant digit)
    // - tight: true (initially restricted by the digits of S)
    // - current_num_mod_k: 0 (initial number is 0)
    // - current_sum_digits_mod_k: 0 (initial sum of digits is 0)
    // - is_started: false (initially in the leading zero phase)
    return dp(0, true, 0, 0, false);
}