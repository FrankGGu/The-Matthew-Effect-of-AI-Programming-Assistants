#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int maxLengthBetweenEqualCharacters(std::string s) {
        std::vector<int> firstIndex(26, -1);
        int maxLength = -1;
        for (int i = 0; i < s.length(); ++i) {
            int charIndex = s[i] - 'a';
            if (firstIndex[charIndex] == -1) {
                firstIndex[charIndex] = i;
            } else {
                maxLength = std::max(maxLength, i - firstIndex[charIndex] - 1);
            }
        }
        return maxLength;
    }
};