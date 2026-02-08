#include <string>
#include <algorithm>
#include <unordered_map>
#include <cmath>

class Solution {
public:
    int getPermutationDifference(std::string s1, std::string s2) {
        if (s1.size() != s2.size()) return -1;

        std::unordered_map<char, int> count;
        for (char c : s1) count[c]++;
        for (char c : s2) {
            if (count[c] == 0) return -1;
            count[c]--;
        }

        int diff = 0;
        for (auto& entry : count) {
            diff += std::abs(entry.second);
        }

        return diff / 2;
    }
};