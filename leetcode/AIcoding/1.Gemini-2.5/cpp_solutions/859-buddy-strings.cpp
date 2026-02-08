#include <string>
#include <vector>
#include <numeric>
#include <algorithm>
#include <unordered_set>

class Solution {
public:
    bool buddyStrings(std::string s, std::string goal) {
        if (s.length() != goal.length()) {
            return false;
        }

        if (s == goal) {
            std::unordered_set<char> distinct_chars;
            for (char c : s) {
                if (distinct_chars.count(c)) {
                    return true;
                }
                distinct_chars.insert(c);
            }
            return false;
        }

        std::vector<int> diff_indices;
        for (int i = 0; i < s.length(); ++i) {
            if (s[i] != goal[i]) {
                diff_indices.push_back(i);
            }
        }

        if (diff_indices.size() != 2) {
            return false;
        }

        return s[diff_indices[0]] == goal[diff_indices[1]] && s[diff_indices[1]] == goal[diff_indices[0]];
    }
};