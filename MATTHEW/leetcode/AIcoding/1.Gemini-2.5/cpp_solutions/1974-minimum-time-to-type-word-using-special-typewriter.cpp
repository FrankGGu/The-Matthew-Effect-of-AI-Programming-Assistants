#include <string>
#include <cmath>
#include <algorithm>

class Solution {
public:
    int minTimeToType(std::string word) {
        int totalTime = 0;
        char currentPos = 'a';
        for (char c : word) {
            int diff = std::abs(c - currentPos);
            totalTime += std::min(diff, 26 - diff) + 1;
            currentPos = c;
        }
        return totalTime;
    }
};