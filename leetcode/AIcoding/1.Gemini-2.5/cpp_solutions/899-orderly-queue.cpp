#include <string>
#include <algorithm>
#include <vector>

class Solution {
public:
    std::string orderlyQueue(std::string s, int k) {
        if (k == 1) {
            std::string min_s = s;
            int n = s.length();
            for (int i = 0; i < n; ++i) {
                // Move the first character to the end
                s = s.substr(1) + s[0];
                if (s < min_s) {
                    min_s = s;
                }
            }
            return min_s;
        } else {
            // If k > 1, we can effectively move any character to any position.
            // This means we can achieve any permutation of the string.
            // To get the lexicographically smallest string, we sort it.
            std::sort(s.begin(), s.end());
            return s;
        }
    }
};