#include <unordered_map>
#include <string>
#include <algorithm>

class Solution {
public:
    int rearrangeCharacters(std::string s, std::string target) {
        std::unordered_map<char, int> sCount, targetCount;
        for (char c : s) sCount[c]++;
        for (char c : target) targetCount[c]++;

        int maxOccurrences = INT_MAX;
        for (const auto& [c, count] : targetCount) {
            if (sCount[c] == 0) return 0;
            maxOccurrences = std::min(maxOccurrences, sCount[c] / count);
        }
        return maxOccurrences;
    }
};