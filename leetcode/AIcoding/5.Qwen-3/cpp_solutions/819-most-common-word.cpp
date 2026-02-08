#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>
#include <cctype>

class Solution {
public:
    std::string mostCommonWord(std::string paragraph, std::vector<std::string> banned) {
        std::unordered_set<std::string> bannedSet(banned.begin(), banned.end());
        std::unordered_map<std::string, int> wordCount;
        std::string word;
        for (char& c : paragraph) {
            if (std::isalpha(c)) {
                word += std::tolower(c);
            } else if (!word.empty()) {
                if (bannedSet.find(word) == bannedSet.end()) {
                    wordCount[word]++;
                }
                word.clear();
            }
        }
        if (!word.empty() && bannedSet.find(word) == bannedSet.end()) {
            wordCount[word]++;
        }

        std::string mostCommon;
        int maxCount = 0;
        for (const auto& pair : wordCount) {
            if (pair.second > maxCount) {
                maxCount = pair.second;
                mostCommon = pair.first;
            }
        }
        return mostCommon;
    }
};