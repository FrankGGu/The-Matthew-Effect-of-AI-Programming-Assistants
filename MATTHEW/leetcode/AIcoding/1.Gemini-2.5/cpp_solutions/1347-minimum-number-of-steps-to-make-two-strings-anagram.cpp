#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    int minSteps(std::string s, std::string t) {
        std::vector<int> count(26, 0);
        for (char c : s) {
            count[c - 'a']++;
        }
        for (char c : t) {
            count[c - 'a']--;
        }

        int steps = 0;
        for (int i = 0; i < 26; ++i) {
            if (count[i] > 0) {
                steps += count[i];
            }
        }
        return steps;
    }
};