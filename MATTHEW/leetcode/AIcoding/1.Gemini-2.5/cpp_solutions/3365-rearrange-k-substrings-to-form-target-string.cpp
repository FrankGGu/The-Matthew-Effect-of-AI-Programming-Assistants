#include <vector>
#include <string>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int rearrangeKSubstrings(std::string s, std::string target, int k) {
        int n = s.length();
        int l = target.length();

        int low = 0, high = n / l, ans = 0;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(mid, s, target, k)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }

private:
    bool check(int m, const std::string& s, const std::string& target, int k) {
        if (m == 0) {
            return true;
        }
        int n = s.length();
        int l = target.length();

        std::vector<int> s_counts(26, 0);
        for (char c : s) s_counts[c - 'a']++;
        std::vector<int> t_counts(26, 0);
        for (char c : target) t_counts[c - 'a']++;

        for (int i = 0; i < 26; ++i) {
            if (s_counts[i] < (long long)m * t_counts[i]) {
                return false;
            }
        }

        std::string t_sorted = target;
        std::sort(t_sorted.begin(), t_sorted.end());

        std::vector<bool> used(n, false);
        const int INF = 1e9;

        for (int iter = 0; iter < m; ++iter) {
            std::vector<std::vector<int>> dp(l, std::vector<int>(n, INF));
            std::vector<std::vector<int>> parent(l, std::vector<int>(n, -1));

            char first_char = t_sorted[0];
            for (int i = 0; i < n; ++i) {
                if (s[i] == first_char && !used[i]) {
                    dp[0][i] = 1;
                }
            }

            for (int j = 1; j < l; ++j) {
                char current_char = t_sorted[j];
                char prev_char = t_sorted[j-1];
                int min_val_sep = INF;
                int min_idx_sep = -1;

                for (int i = 1; i < n; ++i) {
                    if (s[i-1] == prev_char && !used[i-1]) {
                        if (dp[j-1][i-1] < min_val_sep) {
                            min_val_sep = dp[j-1][i-1];
                            min_idx_sep = i-1;
                        }
                    }

                    if (s[i] == current_char && !used[i]) {
                        int cost_adj = INF;
                        if (s[i-1] == prev_char && !used[i-1]) {
                             cost_adj = dp[j-1][i-1];
                        }

                        int cost_non_adj = (min_val_sep == INF) ? INF : min_val_sep + 1;

                        if (cost_adj <= cost_non_adj) {
                            if (cost_adj != INF) {
                                dp[j][i] = cost_adj;
                                parent[j][i] = i - 1;
                            }
                        } else {
                            if (cost_non_adj != INF) {
                                dp[j][i] = cost_non_adj;
                                parent[j][i] = min_idx_sep;
                            }
                        }
                    }
                }
            }

            int min_total_cost = INF;
            int end_idx = -1;
            for (int i = 0; i < n; ++i) {
                if (dp[l-1][i] < min_total_cost) {
                    min_total_cost = dp[l-1][i];
                    end_idx = i;
                }
            }

            if (min_total_cost > k) {
                return false;
            }

            int current_idx = end_idx;
            for (int j = l - 1; j >= 0; --j) {
                used[current_idx] = true;
                if (j > 0) {
                    current_idx = parent[j][current_idx];
                }
            }
        }
        return true;
    }
};