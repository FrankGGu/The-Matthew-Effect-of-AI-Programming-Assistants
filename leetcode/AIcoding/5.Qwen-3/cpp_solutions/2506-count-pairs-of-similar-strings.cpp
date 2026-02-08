#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

class Solution {
public:
    int similarPairs(std::vector<std::string>& words) {
        std::unordered_map<std::string, int> countMap;
        int result = 0;

        for (const auto& word : words) {
            std::string sortedWord = word;
            std::sort(sortedWord.begin(), sortedWord.end());
            result += countMap[sortedWord];
            countMap[sortedWord]++;
        }

        return result;
    }
};