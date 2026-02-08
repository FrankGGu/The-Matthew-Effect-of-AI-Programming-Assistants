#include <vector>
#include <string>
#include <algorithm>
#include <climits> // For INT_MAX

class Solution {
public:
    int get_overlap(const std::string& s1, const std::string& s2) {
        int max_overlap = 0;
        int len1 = s1.length();
        int len2 = s2.length();
        for (int k = 1; k <= std::min(len1, len2); ++k) {
            if (s1.substr(len1 - k) == s2.substr(0, k)) {
                max_overlap = k;
            }
        }
        return max_overlap;
    }

    int minimizeConcatenatedLength(std::vector<std::string>& words) {
        int n = words.size();

        if (n == 0) {
            return 0;
        }
        if (n == 1) {
            return words[0].length();
        }

        std::vector<std::vector<int>> overlap(n, std::vector<int>(n));
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == j) continue;
                overlap[i][j] = get_overlap(words[i], words[j]);
            }
        }

        std::vector<std::vector<int>> dp(1 << n, std::vector<int>(n, INT_MAX / 2));

        for (int i = 0; i < n; ++i) {
            dp[1 << i][i] = words[i].length();
        }

        for (int mask = 1; mask < (1 << n); ++mask) {
            for (int i = 0; i < n; ++i) {
                if ((mask >> i) & 1) {
                    if (dp[mask][i] == INT_MAX / 2) continue;

                    for (int j = 0; j < n; ++j) {
                        if (!((mask >> j) & 1)) {
                            int new_mask = mask | (1 << j);
                            int cost_to_add_j = words[j].length() - overlap[i][j];
                            dp[new_mask][j] = std::min(dp[new_mask][j], dp[mask][i] + cost_to_add_j);
                        }
                    }
                }
            }
        }

        int min_total_length = INT_MAX;
        for (int i = 0; i < n; ++i) {
            min_total_length = std::min(min_total_length, dp[(1 << n) - 1][i]);
        }

        return min_total_length;
    }
};