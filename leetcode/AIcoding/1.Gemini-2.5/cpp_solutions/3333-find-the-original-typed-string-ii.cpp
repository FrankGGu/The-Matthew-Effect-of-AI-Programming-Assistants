#include <string>
#include <vector>
#include <set>
#include <algorithm> // For std::reverse
#include <climits>   // For INT_MAX

class Solution {
private:
    std::vector<std::pair<int, int>> dp; // {length, parent_idx}
    std::vector<char> parent_char;      // char added to parent_idx to get current string
    std::vector<std::vector<int>> memo_compare; // -1: s_i < s_j, 0: s_i == s_j, 1: s_i > s_j, 2: not computed

    int compare_reconstructed_strings_recursive(int i, int j) {
        if (i == j) return 0;
        if (memo_compare[i][j] != 2) return memo_compare[i][j];
        if (memo_compare[j][i] != 2) return -memo_compare[j][i];

        char char_i = parent_char[i];
        char char_j = parent_char[j];

        if (char_i < char_j) {
            memo_compare[i][j] = -1;
            return -1;
        }
        if (char_i > char_j) {
            memo_compare[i][j] = 1;
            return 1;
        }

        // Chars are equal, compare parents
        int res = compare_reconstructed_strings_recursive(dp[i].second, dp[j].second);
        memo_compare[i][j] = res;
        return res;
    }

public:
    std::string findTheOriginalString(std::string typed, std::string brokenKeys) {
        int n = typed.length();

        std::set<char> broken_keys_set;
        for (char c : brokenKeys) {
            broken_keys_set.insert(c);
        }

        auto is_broken = [&](char c) {
            return broken_keys_set.count(c);
        };

        // Initialize member variables for this call
        dp.assign(n + 1, {INT_MAX, -1});
        parent_char.assign(n + 1, 0); // 0 is a placeholder, won't be used for index 0
        memo_compare.assign(n + 1, std::vector<int>(n + 1, 2));

        dp[0] = {0, -1}; // Length 0, no parent

        // Initialize memo_compare for base cases (empty string, index 0)
        for (int i = 0; i <= n; ++i) {
            memo_compare[i][i] = 0;
            if (i != 0) {
                memo_compare[0][i] = -1; // "" < "..."
                memo_compare[i][0] = 1;  // "..." > ""
            }
        }

        for (int i = 1; i <= n; ++i) {
            // Option 1: Last character typed was a working key.
            // This means original string's last char is typed[i-1], and it's a working key.
            char s_char_working = typed[i-1];
            if (!is_broken(s_char_working)) {
                if (dp[i-1].first != INT_MAX) { // If previous state is reachable
                    int candidate_len = dp[i-1].first + 1;
                    int candidate_parent_idx = i-1;
                    char candidate_char = s_char_working;

                    if (candidate_len < dp[i].first) {
                        dp[i] = {candidate_len, candidate_parent_idx};
                        parent_char[i] = candidate_char;
                    } else if (candidate_len == dp[i].first) {
                        // Compare lexicographically
                        // The current string is candidate_parent_idx + candidate_char
                        // The existing string is dp[i].second + parent_char[i]
                        if (candidate_char < parent_char[i]) {
                            dp[i] = {candidate_len, candidate_parent_idx};
                            parent_char[i] = candidate_char;
                        } else if (candidate_char == parent_char[i]) {
                            // If last chars are same, compare their prefixes
                            int cmp = compare_reconstructed_strings_recursive(candidate_parent_idx, dp[i].second);
                            if (cmp < 0) { // candidate_parent_idx's string is smaller
                                dp[i] = {candidate_len, candidate_parent_idx};
                                parent_char[i] = candidate_char;
                            }
                        }
                    }
                }
            }

            // Option 2: Last character typed was a broken key.
            // This means original string's last char is `typed[i-1]`, and it's a broken key.
            // It produced a sequence of `k` identical characters `typed[i-1]` in the typed string.
            char current_char_for_broken_key = typed[i-1];
            if (is_broken(current_char_for_broken_key)) {
                for (int k = 1; k <= i; ++k) {
                    if (typed[i-k] != current_char_for_broken_key) {
                        break; // Sequence of identical characters is broken
                    }
                    // `typed.substr(i-k, k)` consists of `k` copies of `current_char_for_broken_key`.
                    // This means `dp[i-k]` is the state before this broken key was pressed.
                    if (dp[i-k].first != INT_MAX) { // If previous state is reachable
                        int candidate_len = dp[i-k].first + 1;
                        int candidate_parent_idx = i-k;
                        char candidate_char = current_char_for_broken_key;

                        if (candidate_len < dp[i].first) {
                            dp[i] = {candidate_len, candidate_parent_idx};
                            parent_char[i] = candidate_char;
                        } else if (candidate_len == dp[i].first) {
                            // Compare lexicographically
                             if (candidate_char < parent_char[i]) {
                                dp[i] = {candidate_len, candidate_parent_idx};
                                parent_char[i] = candidate_char;
                            } else if (candidate_char == parent_char[i]) {
                                int cmp = compare_reconstructed_strings_recursive(candidate_parent_idx, dp[i].second);
                                if (cmp < 0) { // candidate_parent_idx's string is smaller
                                    dp[i] = {candidate_len, candidate_parent_idx};
                                    parent_char[i] = candidate_char;
                                }
                            }
                        }
                    }
                }
            }
        }

        // Reconstruct the result string
        std::string result = "";
        int current_idx = n;
        while (current_idx != 0) {
            result += parent_char[current_idx];
            current_idx = dp[current_idx].second;
        }
        std::reverse(result.begin(), result.end());
        return result;
    }
};