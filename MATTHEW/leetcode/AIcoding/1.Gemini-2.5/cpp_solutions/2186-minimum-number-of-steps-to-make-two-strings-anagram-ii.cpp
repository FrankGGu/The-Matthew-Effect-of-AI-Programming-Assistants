#include <string>
#include <vector>
#include <cmath>

class Solution {
public:
    int minSteps(std::string s, std::string t) {
        std::vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }
        for (char c : t) {
            freq[c - 'a']--;
        }

        int steps = 0;
        for (int count : freq) {
            steps += std::abs(count);
        }

        return steps;
    }
};