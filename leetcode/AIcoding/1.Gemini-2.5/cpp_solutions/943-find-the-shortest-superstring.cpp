#include <vector>
#include <string>
#include <algorithm>
#include <climits>

class Solution {
public:
    int calculateOverlap(const std::string& s1, const std::string& s2) {
        int max_overlap = 0;
        int min_len = std::min(s1.length(), s2.length());
        for (int k = 1; k <= min_len; ++k) {
            if (s1.substr(s1.length() - k) == s2.substr(0, k)) {
                max_overlap = k;
            }
        }
        return max_overlap;
    }

    std::string shortestSuperstring(std::vector<std::string>& words) {
        int n = words.size();

        std::vector<std::vector<int>> overlap(n, std::vector<int>(n));
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == j) continue;
                overlap[i][j] = calculateOverlap(words[i], words[j]);
            }
        }

        std::vector<std::vector<int>> dp(1 << n, std::vector<int>(n, INT_MAX / 2));
        std::vector<std::vector<int>> path(1 << n, std::vector<int>(n, -1));

        for (int i = 0; i < n; ++i) {
            dp[1 << i][i] = words[i].length();
        }

        for (int mask = 1; mask < (1 << n); ++mask) {
            for (int i = 0; i < n; ++i) {
                if (!(mask & (1 << i))) continue;

                for (int j = 0; j < n; ++j) {
                    if (mask & (1 << j)) continue;

                    int new_mask = mask | (1 << j);
                    int current_len = dp[mask][i];
                    int cost_to_add_j = words[j].length() - overlap[i][j];

                    if (current_len + cost_to_add_j < dp[new_mask][j]) {
                        dp[new_mask][j] = current_len + cost_to_add_j;
                        path[new_mask][j] = i;
                    }
                }
            }
        }

        int min_len = INT_MAX / 2;
        int last_string_idx = -1;
        int final_mask = (1 << n) - 1;

        for (int i = 0; i < n; ++i) {
            if (dp[final_mask][i] < min_len) {
                min_len = dp[final_mask][i];
                last_string_idx = i;
            }
        }

        std::vector<int> order_rev;
        int current_mask = final_mask;
        int current_last_idx = last_string_idx;

        while (current_mask != 0) {
            order_rev.push_back(current_last_idx);
            int prev_idx = path[current_mask][current_last_idx];
            current_mask ^= (1 << current_last_idx);
            current_last_idx = prev_idx;
        }
        std::reverse(order_rev.begin(), order_rev.end());

        std::string result = words[order_rev[0]];
        for (int k = 1; k < n; ++k) {
            int prev_s_idx = order_rev[k-1];
            int curr_s_idx = order_rev[k];
            result += words[curr_s_idx].substr(overlap[prev_s_idx][curr_s_idx]);
        }

        return result;
    }
};