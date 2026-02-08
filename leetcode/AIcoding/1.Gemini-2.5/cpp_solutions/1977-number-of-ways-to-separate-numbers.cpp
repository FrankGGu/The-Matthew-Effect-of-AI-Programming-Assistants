#include <string>
#include <vector>
#include <numeric>
#include <algorithm> // For std::min

class Solution {
public:
    int numberOfWays(std::string num) {
        int n = num.length();
        long long MOD = 1e9 + 7;

        // lcp[i][j] stores the length of the longest common prefix of num.substr(i) and num.substr(j)
        // lcp[i][j] is computed for suffixes starting at index i and j.
        std::vector<std::vector<int>> lcp(n + 1, std::vector<int>(n + 1, 0));
        for (int i = n - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                if (num[i] == num[j]) {
                    lcp[i][j] = 1 + lcp[i + 1][j + 1];
                } else {
                    lcp[i][j] = 0;
                }
            }
        }

        // dp[i][j] = number of ways to separate num[0...i-1] such that the last number is num[i-j...i-1]
        std::vector<std::vector<long long>> dp(n + 1, std::vector<long long>(n + 1, 0));

        // prev_sum[i][j] = sum(dp[i][k] for k from 1 to j)
        // This is a prefix sum for dp values at index i, used to optimize summing over previous lengths.
        std::vector<std::vector<long long>> prev_sum(n + 1, std::vector<long long>(n + 1, 0));

        for (int i = 1; i <= n; ++i) { // i is the current ending index (exclusive) of the prefix being separated (num[0...i-1])
            for (int j = 1; j <= i; ++j) { // j is the length of the last number num[i-j...i-1]
                if (num[i - j] == '0') { // If the current number has a leading zero, it's invalid
                    prev_sum[i][j] = prev_sum[i][j-1]; // Carry over sum from shorter lengths for current 'i'
                    continue;
                }

                if (j == i) { // This is the first and only number in the sequence (e.g., "123" itself)
                    dp[i][j] = 1;
                } else {
                    int prev_end_idx = i - j; // The end index (exclusive) of the previous number's sequence (num[0...prev_end_idx-1])

                    // Case 1: Previous number (length k) is shorter than current number (length j)
                    // num[prev_end_idx-k ... prev_end_idx-1] < num[i-j ... i-1]
                    // This comparison is always true if k < j.
                    // We need to sum dp[prev_end_idx][k] for k from 1 up to min(j-1, prev_end_idx).
                    // 'prev_end_idx' is the maximum possible length for a number ending at 'prev_end_idx-1'.
                    long long ways_from_shorter_prev = 0;
                    if (j - 1 >= 1) { // Ensure there are valid shorter lengths (k >= 1)
                        ways_from_shorter_prev = prev_sum[prev_end_idx][std::min(j - 1, prev_end_idx)];
                    }
                    dp[i][j] = (dp[i][j] + ways_from_shorter_prev) % MOD;

                    // Case 2: Previous number (length k) is equal to current number (length j)
                    // num[prev_end_idx-j ... prev_end_idx-1] vs num[i-j ... i-1]
                    // This is only possible if j <= prev_end_idx, as the previous number must fit in num[0...prev_end_idx-1]
                    if (j <= prev_end_idx) {
                        int prev_num_start_idx = prev_end_idx - j;
                        int current_num_start_idx = i - j;

                        int common_prefix_len = lcp[prev_num_start_idx][current_num_start_idx];

                        // If common_prefix_len >= j, the two numbers (of equal length j) are identical.
                        // In this case, current_num is NOT strictly greater than prev_num.
                        // If common_prefix_len < j, then we compare the characters at the first differing position.
                        if (common_prefix_len < j) {
                            if (num[current_num_start_idx + common_prefix_len] > num[prev_num_start_idx + common_prefix_len]) {
                                dp[i][j] = (dp[i][j] + dp[prev_end_idx][j]) % MOD;
                            }
                        }
                    }
                }
                // Update prefix sum for dp values ending at index i
                prev_sum[i][j] = (prev_sum[i][j-1] + dp[i][j]) % MOD;
            }
        }

        // The total number of ways to separate num[0...n-1] is the sum of dp[n][j] for all valid j.
        // This is precisely prev_sum[n][n].
        return prev_sum[n][n];
    }
};