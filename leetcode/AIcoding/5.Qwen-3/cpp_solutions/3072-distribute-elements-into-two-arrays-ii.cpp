#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    int areAlmostEqual(const std::string& s, const std::string& goal) {
        std::vector<int> diff;
        for (int i = 0; i < s.size(); ++i) {
            if (s[i] != goal[i]) {
                diff.push_back(i);
            }
        }
        return diff.size() == 0 || (diff.size() == 2 && s[diff[0]] == goal[diff[1]] && s[diff[1]] == goal[diff[0]]);
    }
};