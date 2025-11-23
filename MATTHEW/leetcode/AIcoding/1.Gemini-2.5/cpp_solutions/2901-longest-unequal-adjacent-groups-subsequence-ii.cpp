#include <vector>
#include <string>
#include <algorithm>
#include <utility> // For std::pair

const int UNCOMPUTED = 2;

int comparePaths(int i, int j, const std::vector<std::string>& groups,
                 const std::vector<std::pair<int, int>>& dp,
                 std::vector<std::vector<int>>& memo) {
    // Base case: If both paths are empty (i.e., we've reached the start of both paths)
    // they are considered identical for comparison purposes.
    if (i == -1) { // This implies j == -1 as paths being compared have the same length
        return 0;
    }

    // Check memoization table
    if (memo[i][j] != UNCOMPUTED) {
        return memo[i][j];
    }

    // Recursively compare the prefixes of the paths
    int res = comparePaths(dp[i].second, dp[j].second, groups, dp, memo);

    if (res != 0) {
        // If prefixes are different, their comparison result determines the overall result
        memo[i][j] = res;
        memo[j][i] = -res; // Store the symmetric result
        return res;
    }

    // If prefixes are identical, compare the current elements (groups[i] and groups[j])
    if (groups[i] < groups[j]) {
        memo[i][j] = 1;
        memo[j][i] = -1;
        return 1;
    }
    if (groups[i] > groups[j]) {
        memo[i][j] = -1;
        memo[j][i] = 1;
        return -1;
    }

    // If current elements are also identical, the paths are identical
    memo[i][j] = 0;
    memo[j][i] = 0;
    return 0;
}

class Solution {
public:
    std::vector<std::string> getLongestSubsequence(std::vector<std::string>& groups) {
        int n = groups.size();
        if (n == 0) {
            return {};
        }

        // dp[i] stores {length_of_longest_subsequence_ending_at_i, previous_index_in_that_subsequence}
        std::vector<std::pair<int, int>> dp(n);
        // Initialize dp: each group itself forms a subsequence of length 1
        for (int i = 0; i < n; ++i) {
            dp[i] = {1, -1}; // -1 indicates no previous element
        }

        // memo[i][j] stores the comparison result between path ending at i and path ending at j
        // 1: path_i < path_j, -1: path_i > path_j, 0: path_i == path_j
        // Initialized to UNCOMPUTED (2)
        std::vector<std::vector<int>> memo(n, std::vector<int>(n, UNCOMPUTED));

        int max_len = 1;
        int last_idx_of_max_len_path = 0; // Index of the last element of the overall best path found so far

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                // Check conditions for groups[j] to be followed by groups[i]
                if (groups[j].length() != groups[i].length() && groups[j][0] != groups[i][0]) {
                    if (dp[j].first + 1 > dp[i].first) {
                        // Found a longer subsequence ending at i
                        dp[i].first = dp[j].first + 1;
                        dp[i].second = j;
                    } else if (dp[j].first + 1 == dp[i].first) {
                        // Found a subsequence of the same length ending at i
                        // Need to compare lexicographically
                        // If path ending at j is smaller than current best path ending at dp[i].second
                        if (comparePaths(j, dp[i].second, groups, dp, memo) == 1) {
                            dp[i].second = j; // Update to the lexicographically smaller path
                        }
                    }
                }
            }

            // After computing dp[i], update the overall longest subsequence
            if (dp[i].first > max_len) {
                max_len = dp[i].first;
                last_idx_of_max_len_path = i;
            } else if (dp[i].first == max_len) {
                // If current path ending at i has the same max_len
                // Compare it with the current overall best path (ending at last_idx_of_max_len_path)
                if (comparePaths(i, last_idx_of_max_len_path, groups, dp, memo) == 1) {
                    last_idx_of_max_len_path = i; // Update to the lexicographically smaller path
                }
            }
        }

        // Reconstruct the longest lexicographically smallest subsequence
        std::vector<std::string> result;
        int curr = last_idx_of_max_len_path;
        while (curr != -1) {
            result.push_back(groups[curr]);
            curr = dp[curr].second;
        }
        std::reverse(result.begin(), result.end());

        return result;
    }
};