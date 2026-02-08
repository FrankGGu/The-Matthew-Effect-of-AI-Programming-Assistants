#include <string>
#include <cmath> // Required for std::abs

class Solution {
public:
    int findMirrorScore(std::string s) {
        int score = 0;
        int n = s.length();
        for (int i = 0; i < n / 2; ++i) {
            score += std::abs(s[i] - s[n - 1 - i]);
        }
        return score;
    }
};