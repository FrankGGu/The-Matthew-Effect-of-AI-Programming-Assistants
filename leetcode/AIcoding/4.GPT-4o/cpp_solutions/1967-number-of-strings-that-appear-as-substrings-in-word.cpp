#include <vector>
#include <string>
#include <unordered_set>

class Solution {
public:
    int numOfStrings(std::vector<std::string>& patterns, std::string word) {
        std::unordered_set<std::string> patternSet(patterns.begin(), patterns.end());
        int count = 0;
        for (const auto& pattern : patternSet) {
            if (word.find(pattern) != std::string::npos) {
                count++;
            }
        }
        return count;
    }
};