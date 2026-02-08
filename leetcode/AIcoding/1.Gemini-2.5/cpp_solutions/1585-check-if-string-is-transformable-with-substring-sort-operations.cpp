#include <string>
#include <vector>
#include <queue>
#include <numeric>

class Solution {
public:
    bool isTransformable(std::string s, std::string t) {
        int n = s.length();

        std::vector<int> s_counts(10, 0);
        std::vector<int> t_counts(10, 0);
        for (char c : s) {
            s_counts[c - '0']++;
        }
        for (char c : t) {
            t_counts[c - '0']++;
        }
        for (int i = 0; i < 10; ++i) {
            if (s_counts[i] != t_counts[i]) {
                return false;
            }
        }

        std::vector<std::queue<int>> s_indices(10);
        for (int i = 0; i < n; ++i) {
            s_indices[s[i] - '0'].push(i);
        }

        for (int k = 0; k < n; ++k) {
            int target_digit = t[k] - '0';

            int current_s_original_idx = s_indices[target_digit].front();
            s_indices[target_digit].pop();

            for (int d = 0; d < target_digit; ++d) {
                if (!s_indices[d].empty() && s_indices[d].front() < current_s_original_idx) {
                    return false;
                }
            }
        }

        return true;
    }
};