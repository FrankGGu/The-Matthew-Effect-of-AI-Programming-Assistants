#include <string.h>
#include <stdbool.h>

#define MIN(a, b) ((a) < (b) ? (a) : (b))

#define MAX_N 4001
#define MOD 1000000007

int lcp[MAX_N][MAX_N];
int dp[MAX_N][MAX_N];
int prefix_sum_dp[MAX_N][MAX_N]; // prefix_sum_dp[i][k] = sum(dp[i][l] for l=1 to k)

static inline bool is_less_equal_fixed_len(const char* s, int idx1, int idx2, int len) {
    int common_prefix_len = lcp[idx1][idx2];
    if (common_prefix_len >= len) {
        return true; // s1 == s2
    }
    // Compare characters at first differing position
    return s[idx1 + common_prefix_len] < s[idx2 + common_prefix_len];
}

int numberOfWays(char * s){
    int n = strlen(s);

    // Initialize arrays to 0. Global arrays are zero-initialized by default,
    // but explicit memset can be used for clarity or if arrays were local/dynamic.
    // For competitive programming, global arrays are often assumed to be zero-initialized.
    // memset(lcp, 0, sizeof(lcp));
    // memset(dp, 0, sizeof(dp));
    // memset(prefix_sum_dp, 0, sizeof(prefix_sum_dp));

    // Compute LCP (Longest Common Prefix) array
    // lcp[i][j] stores the length of the longest common prefix of s[i...] and s[j...]
    for (int i = n - 1; i >= 0; --i) {
        for (int j = n - 1; j >= 0; --j) {
            if (s[i] == s[j]) {
                lcp[i][j] = 1 + lcp[i + 1][j + 1];
            } else {
                lcp[i][j] = 0;
            }
        }
    }

    // Base case for DP: an empty prefix has one way (to start forming the first number)
    // dp[i][len] = number of ways to separate s[0...i-1] such that the last number has length `len`.
    dp[0][0] = 1;

    // DP calculation
    for (int i = 1; i <= n; ++i) { // `i` is the current end index (exclusive for next number start, inclusive for current number end)
        // `prefix_sum_dp[i][0]` is implicitly 0.
        for (int len = 1; len <= i; ++len) { // `len` is the length of the last number `s[i-len ... i-1]`
            int current_num_start = i - len;

            if (s[current_num_start] == '0') { // Number has a leading zero, invalid.
                // dp[i][len] remains 0.
                // prefix_sum_dp[i][len] will simply inherit from prefix_sum_dp[i][len-1].
                prefix_sum_dp[i][len] = prefix_sum_dp[i][len-1];
                continue;
            }

            // Case 1: s[current_num_start ... i-1] is the first number in the sequence.
            if (current_num_start == 0) {
                dp[i][len] = (dp[i][len] + 1) % MOD; // One way to form this first number (from an empty prefix).
            }
            // Case 2: s[current_num_start ... i-1] is not the first number.
            else {
                // We need to sum `dp[current_num_start][prev_len]` where `prev_num <= current_num`.
                // `prev_num = s[current_num_start-prev_len ... current_num_start-1]`
                // `current_num = s[current_num_start ... i-1]`

                // Add ways where `prev_len < len`.
                // A shorter positive number is always less than a longer positive number.
                // `prev_len` can be from 1 up to `min(current_num_start, len-1)`.
                int limit_prev_len = MIN(current_num_start, len - 1);
                if (limit_prev_len >= 1) {
                    dp[i][len] = (dp[i][len] + prefix_sum_dp[current_num_start][limit_prev_len]) % MOD;
                }

                // Add ways where `prev_len == len`.
                // `prev_len` must be `len`. This is only possible if `len <= current_num_start`.
                if (len <= current_num_start) {
                    // Compare `s[current_num_start-len ... current_num_start-1]` with `s[current_num_start ... i-1]`
                    int prev_num_start = current_num_start - len;
                    if (is_less_equal_fixed_len(s, prev_num_start, current_num_start, len)) {
                        dp[i][len] = (dp[i][len] + dp[current_num_start][len]) % MOD;
                    }
                }
            }
            // Update prefix_sum_dp for current `i` and `len`
            prefix_sum_dp[i][len] = (prefix_sum_dp[i][len-1] + dp[i][len]) % MOD;
        }
    }

    // The total number of ways to separate the entire string s[0...n-1]
    // is the sum of all dp[n][len] for len from 1 to n.
    // This sum is conveniently stored in prefix_sum_dp[n][n].
    return prefix_sum_dp[n][n];
}