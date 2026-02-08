#include <string>
#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    std::string shortestCompletingWord(std::string licensePlate, std::vector<std::string>& words) {
        std::unordered_map<char, int> count;
        for (char c : licensePlate) {
            if (std::isalpha(c)) {
                count[tolower(c)]++;
            }
        }

        std::string result;
        for (const std::string& word : words) {
            std::unordered_map<char, int> tempCount = count;
            for (char c : word) {
                if (tempCount.count(c)) {
                    tempCount[c]--;
                }
            }
            if (std::all_of(tempCount.begin(), tempCount.end(), [](const auto& p) { return p.second <= 0; })) {
                if (result.empty() || word.length() < result.length()) {
                    result = word;
                }
            }
        }
        return result;
    }
};