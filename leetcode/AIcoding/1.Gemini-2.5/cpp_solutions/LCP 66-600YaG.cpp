#include <string>
#include <vector>
#include <algorithm>
#include <map>

class Solution {
public:
    std::string minBooths(std::vector<std::string>& booths) {
        std::vector<int> maxFreq(26, 0);

        for (const std::string& booth : booths) {
            std::vector<int> currentFreq(26, 0);
            for (char c : booth) {
                currentFreq[c - 'a']++;
            }
            for (int i = 0; i < 26; ++i) {
                maxFreq[i] = std::max(maxFreq[i], currentFreq[i]);
            }
        }

        std::string result = "";
        for (int i = 0; i < 26; ++i) {
            for (int j = 0; j < maxFreq[i]; ++j) {
                result += (char)('a' + i);
            }
        }

        return result;
    }
};