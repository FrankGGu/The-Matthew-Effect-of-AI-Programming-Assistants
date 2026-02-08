#include <string>
#include <vector>

class Solution {
public:
    int uniqueLetterString(std::string s) {
        int n = s.length();
        std::vector<std::vector<int>> char_indices(26);

        for (int i = 0; i < 26; ++i) {
            char_indices[i].push_back(-1);
        }

        for (int i = 0; i < n; ++i) {
            char_indices[s[i] - 'A'].push_back(i);
        }

        for (int i = 0; i < 26; ++i) {
            char_indices[i].push_back(n);
        }

        long long total_sum = 0;

        for (int i = 0; i < 26; ++i) {
            for (size_t j = 1; j < char_indices[i].size() - 1; ++j) {
                int current_idx = char_indices[i][j];
                int prev_idx = char_indices[i][j-1];
                int next_idx = char_indices[i][j+1];

                total_sum += (long long)(current_idx - prev_idx) * (next_idx - current_idx);
            }
        }

        return static_cast<int>(total_sum);
    }
};