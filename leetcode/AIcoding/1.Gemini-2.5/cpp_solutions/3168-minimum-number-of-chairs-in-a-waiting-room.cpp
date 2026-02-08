#include <string>
#include <algorithm>

class Solution {
public:
    int minimumChairs(std::string s) {
        int currentChairs = 0;
        int maxChairs = 0;
        for (char c : s) {
            if (c == 'E') {
                currentChairs++;
            } else {
                currentChairs--;
            }
            maxChairs = std::max(maxChairs, currentChairs);
        }
        return maxChairs;
    }
};