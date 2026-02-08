#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

class Solution {
public:
    int numberOfSpecialChars(std::string word) {
        std::unordered_map<char, int> lowerCount;
        std::unordered_map<char, int> upperCount;

        for (char c : word) {
            if (islower(c)) {
                lowerCount[c]++;
            } else {
                upperCount[c]++;
            }
        }

        int result = 0;

        for (auto& [c, count] : lowerCount) {
            char upperC = toupper(c);
            if (upperCount.find(upperC) != upperCount.end() && upperCount[upperC] > 0) {
                result++;
            }
        }

        return result;
    }
};